SELECT
    ps.PatientId
    
    ,DATEADD(DAY, -14, ps.AdmittedDate) AS reminderDate
    
    ,DATEDIFF(DAY, ps.AdmittedDate, ps.DischargeDate) AS LengthofStay
    
    ,ps.AdmittedDate
    
    ,ps.DischargeDate
    
    ,ps.Hospital
    
    ,ps.Ward
    
    ,ps.Tariff
FROM
    PatientStay ps
WHERE ps.Hospital IN ('Kingston', 'PRUH' )
    -- AND ps.Ward LIKE '%Surgery'
    AND ps.AdmittedDate >= DATEFROMPARTS(2024, 2, 27)
    AND ps.DischargeDate BETWEEN '2024-03-03' AND '2024-03-05'
    AND ps.Tariff > 7
ORDER BY 
    ps.AdmittedDate
    , ps.DischargeDate


SELECT
    ps.Hospital
        
    ,ps.Ward
        
    ,COUNT (*) AS NumberOfPatients 
        
    ,SUM (ps.Tariff) AS TotalTariff
        
    ,AVG(ps.Tariff) AS AvgTariff
FROM
    PatientStay ps
-- WHERE ps.Hospital IN ('Oxleas' , 'PRUH')
GROUP BY ps.Hospital , ps.Ward
HAVING Count(*) > 3
ORDER BY NumberOfPatients DESC
-- ORDER BY ps.Hospital , ps.Ward

SELECT
    *
FROM
    DimHospitalBad

SELECT
    ps.PatientId      
    ,ps.Hospital        
    ,h.Hospital 
    ,ps.AdmittedDate
    ,h.HospitalType
    ,h.HospitalSize
FROM
    PatientStay ps FULL OUTER JOIN DimHospitalBad h ON  ps.Hospital = h.Hospital