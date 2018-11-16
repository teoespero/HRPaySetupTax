/*
	
	HRPaySetupTax
	The HRPaySetupTax table defines the tax setup for the employee, 
	including any additional income tax amount to be withheld, and 
	statutory tax flags such as Medicare, OASDI, etc.
*/

select 
	DistrictID,
	rtrim(DistrictAbbrev) as DistrictAbbrev,
	DistrictTitle
from tblDistrict

select 
	(select DistrictId from tblDistrict) as OrgId,
	te.EmployeeID as EmpId,
	te.Fullname,
	te.SocSecNo,
	te.WarrantSiteID,
	si.SiteCode,
	si.SiteName as WarrantSite,
	(case when isnull(te.IsDeferredPay,0) = 1 then 'Yes' Else 'No' end) as DeferredPay,
	certRet.RetireClass as CertRetire,
	classRet.RetireClass as ClassRetire,
	null as DateFrom,
	null as DateThru,
	null as OASDI,
	null as Medicare,
	null as SUI,
	null as WComp,
	null as SDI,
	null as UseSuppTaxOnNonPrimary,
	null as EnableHomeStateTax,
	null as Comment,
	te.FedExemptions as ExemptionFederal,
	null as SupplAmtFederal,
	null as SupplPctFederal,
	null as AEIC,
	te.FedMaritalStatus as MaritalStatusFedID,
	ma.[Description] as MaritalStatusFed,
	te.StateMaritalStatus as MaritalStatusStateID,
	st.[Description] as MaritalStatusState,
	te.StateExemptions as ExemptionState,
	null as EstimatedState,
	null as SupplAmtState,
	null as SupplPctState,
	null as MaritalStatusLocal,
	null as ExemptionLocal,
	null as SupplAmtLocal,
	null as SupplPctLocal
from tblEmployee te
left join
	tblSite si
	on te.WarrantSiteID = si.SiteID
left join
	tblRetireClass classRet
	on te.ClassRetireId = classRet.RetireClassID
left join
	tblRetireClass certRet
	on te.CertRetireId = certRet.RetireClassID
left join
	DS_Global..MaritalStatus ma
	on ma.Id = isnull(cast(te.FedMaritalStatus as decimal),0)
left join
	DS_Global..MaritalStatus st
	on st.Id = isnull(cast(te.StateMaritalStatus as decimal),0)
where
	te.TerminateDate is null
	and te.EmployeeID > 0
