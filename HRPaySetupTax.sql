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
	EmployeeID as EmpId,
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
	FedMaritalStatus as MaritalStatusFederal,
	FedExemptions as ExemptionFederal,
	null as SupplAmtFederal,
	null as SupplPctFederal,
	null as AEIC,
	StateMaritalStatus as MaritalStatusState,
	StateExemptions as ExemptionState,
	null as EstimatedState,
	null as SupplAmtState,
	null as SupplPctState,
	null as MaritalStatusLocal,
	null as ExemptionLocal,
	null as SupplAmtLocal,
	null as SupplPctLocal
from tblEmployee te
where
	te.TerminateDate is null