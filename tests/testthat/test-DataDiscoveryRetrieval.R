test_that("TADA_DataRetrieval", {
  tada1 <- TADA::TADA_DataRetrieval(
    siteid = c(
      "USGS-054064785",
      "USGS-430305089260600"
    ),
    characteristicName = "Phosphorus"
  )
  # you could just pick the important columns:
  expect_true(all(c(
    "OrganizationIdentifier",
    "OrganizationFormalName",
    "ActivityIdentifier",
    "ActivityTypeCode",
    "ActivityMediaName",
    "TADA.ActivityMediaName",
    "ActivityMediaSubdivisionName",
    "ActivityStartDate",
    "ActivityStartTime.Time",
    "ActivityStartTime.TimeZoneCode",
    "ActivityEndDate",
    "ActivityEndTime.Time",
    "ActivityEndTime.TimeZoneCode",
    "ActivityRelativeDepthName",
    "ActivityDepthHeightMeasure.MeasureValue",
    "ActivityDepthHeightMeasure.MeasureUnitCode",
    "ActivityDepthAltitudeReferencePointText",
    "ActivityTopDepthHeightMeasure.MeasureValue",
    "ActivityTopDepthHeightMeasure.MeasureUnitCode",
    "ActivityBottomDepthHeightMeasure.MeasureValue",
    "ActivityBottomDepthHeightMeasure.MeasureUnitCode",
    "ProjectIdentifier",
    "ProjectName",
    "ActivityConductingOrganizationText",
    "MonitoringLocationIdentifier",
    "MonitoringLocationName",
    "ActivityCommentText",
    "SampleAquifer",
    "HydrologicCondition",
    "HydrologicEvent",
    "SampleCollectionMethod.MethodIdentifier",
    "SampleCollectionMethod.MethodIdentifierContext",
    "SampleCollectionMethod.MethodName",
    "SampleCollectionEquipmentName",
    "ActivityLocation.LatitudeMeasure",
    "ActivityLocation.LongitudeMeasure",
    "ResultDetectionConditionText",
    "MethodSpeciationName",
    "CharacteristicName",
    "TADA.CharacteristicName",
    "ResultSampleFractionText",
    "ResultMeasureValue",
    "TADA.ResultMeasureValue",
    "TADA.ResultMeasureValueDataTypes.Flag",
    "ResultMeasure.MeasureUnitCode",
    "TADA.ResultMeasure.MeasureUnitCode",
    "MeasureQualifierCode",
    "ResultStatusIdentifier",
    "StatisticalBaseCode",
    "ResultValueTypeName",
    "ResultWeightBasisText",
    "ResultTimeBasisText",
    "ResultTemperatureBasisText",
    "ResultParticleSizeBasisText",
    "DataQuality.PrecisionValue",
    "DataQuality.BiasValue",
    "DataQuality.ConfidenceIntervalValue",
    "DataQuality.UpperConfidenceLimitValue",
    "DataQuality.LowerConfidenceLimitValue",
    "ResultCommentText",
    "USGSPCode",
    "ResultDepthHeightMeasure.MeasureValue",
    "ResultDepthHeightMeasure.MeasureUnitCode",
    "ResultDepthAltitudeReferencePointText",
    "SubjectTaxonomicName",
    "SampleTissueAnatomyName",
    "BinaryObjectFileName",
    "BinaryObjectFileTypeCode",
    "ResultFileUrl",
    "ResultAnalyticalMethod.MethodIdentifier",
    "ResultAnalyticalMethod.MethodIdentifierContext",
    "ResultAnalyticalMethod.MethodName",
    "ResultAnalyticalMethod.MethodUrl",
    "ResultAnalyticalMethod.MethodDescriptionText",
    "LaboratoryName",
    "AnalysisStartDate",
    "ResultLaboratoryCommentText",
    "ResultDetectionQuantitationLimitUrl",
    "DetectionQuantitationLimitTypeName",
    "DetectionQuantitationLimitMeasure.MeasureValue",
    "TADA.DetectionQuantitationLimitMeasure.MeasureValue",
    "TADA.DetectionQuantitationLimitMeasure.MeasureValueDataTypes.Flag",
    "DetectionQuantitationLimitMeasure.MeasureUnitCode",
    "LabSamplePreparationUrl",
    "LastUpdated",
    "ProviderName",
    "timeZoneStart",
    "timeZoneEnd",
    "ActivityStartDateTime",
    "ActivityEndDateTime",
    "MonitoringLocationTypeName",
    "MonitoringLocationDescriptionText",
    "HUCEightDigitCode",
    "DrainageAreaMeasure.MeasureValue",
    "DrainageAreaMeasure.MeasureUnitCode",
    "ContributingDrainageAreaMeasure.MeasureValue",
    "ContributingDrainageAreaMeasure.MeasureUnitCode",
    "LatitudeMeasure",
    "TADA.LatitudeMeasure",
    "LongitudeMeasure",
    "TADA.LongitudeMeasure",
    "SourceMapScaleNumeric",
    "HorizontalAccuracyMeasure.MeasureValue",
    "HorizontalAccuracyMeasure.MeasureUnitCode",
    "HorizontalCollectionMethodName",
    "HorizontalCoordinateReferenceSystemDatumName",
    "VerticalMeasure.MeasureValue",
    "VerticalMeasure.MeasureUnitCode",
    "VerticalAccuracyMeasure.MeasureValue",
    "VerticalAccuracyMeasure.MeasureUnitCode",
    "VerticalCollectionMethodName",
    "VerticalCoordinateReferenceSystemDatumName",
    "CountryCode",
    "StateCode",
    "CountyCode",
    "AquiferName",
    "LocalAqfrName",
    "FormationTypeText",
    "AquiferTypeName",
    "ConstructionDateText",
    "WellDepthMeasure.MeasureValue",
    "WellDepthMeasure.MeasureUnitCode",
    "WellHoleDepthMeasure.MeasureValue",
    "WellHoleDepthMeasure.MeasureUnitCode",
    "MethodSpeciationName"
  ) %in% names(tada1)))
})

# testing that NWIS USGS only domain value "meters" is successfully replaced with "m". This feature is part of the TADA_AutoClean function
# which runs automatically when TADA_DataRetrieval runs
test_that("TADA_DataRetrieval", {
  check_autoclean_meters_works <- TADA::TADA_DataRetrieval(
    statecode = "UT",
    characteristicName = c("Ammonia", "Nitrate", "Nitrogen"),
    startDate = "2021-01-01"
  )
  expect_false("meters" %in% check_autoclean_meters_works$TADA.ResultMeasure.MeasureUnitCode)
})

# Testing that regular and big data retrieval return the same number of rows on an identical query.
# cm edited to include start date on 2/27/23 because without this it takes too long to run
# these tests, and may time out
test_that("Reg&BigdataRetrieval", {
  big <- TADA::TADA_BigDataRetrieval(characteristicName = "Algae, substrate rock/bank cover (choice list)", sampleMedia = "Water", siteType = "Stream", startDate = "2020-01-01", applyautoclean = FALSE)
  reg <- TADA::TADA_DataRetrieval(characteristicName = "Algae, substrate rock/bank cover (choice list)", sampleMedia = "Water", siteType = "Stream", startDate = "2020-01-01", applyautoclean = FALSE)

  expect_equal(nrow(big), nrow(reg))
})

# Testing that dates work correctly in queries in big data retrieval
test_that("BigdataRetrieval_daterange", {
  startDate <- "2018-10-01"
  endDate <- "2021-09-30"
  big <- TADA::TADA_BigDataRetrieval(startDate = startDate, endDate = endDate, huc = c("04030202", "04030201"), characteristicName = "Escherichia coli", siteType = "Stream")
  logic <- min(big$ActivityStartDate) >= as.Date(startDate, format = "%Y-%m-%d") & max(big$ActivityStartDate) <= as.Date(endDate, format = "%Y-%m-%d")

  expect_true(logic)
})


# Testing that the TADA_JoinWQPProfiles() function in DataDiscoveryRetrieval.R
# has the expected number of columns after joining the full physical chemical
# profile and the sites profiles together. This function uses cyanobacteria
# full phys chem results and station metadata.


test_that("TADA_JoinWQPProfiles_works", {
  # testthat::test_path() is automatically set to "tests/testthat". To get to the data files, you
  # only need to add the additional pathway e.g., not the full path i.e.,
  # "tests/testthat/testdata/Cyan_Stations.rds" but "testdata/Cyan_Results.rds"
  physchemresults <- readRDS(testthat::test_path("testdata/Cyan_Results.rds"))

  stations <- readRDS(testthat::test_path("testdata/Cyan_Stations.rds"))

  add_sites_metadata <- TADA::TADA_JoinWQPProfiles(
    Sites = stations,
    FullPhysChem = physchemresults
  )

  expect_true(ncol(add_sites_metadata) == 113)
})


test_that("TADA_JoinWQPProfiles_columns", {
  stationProfile <- TADA::TADA_ReadWQPWebServices("https://www.waterqualitydata.us/data/Station/search?statecode=US%3A09&characteristicType=Nutrient&startDateLo=04-01-2023&startDateHi=11-01-2023&mimeType=csv&zip=yes&providers=NWIS&providers=STEWARDS&providers=STORET")
  physchemProfile <- TADA::TADA_ReadWQPWebServices("https://www.waterqualitydata.us/data/Result/search?statecode=US%3A09&characteristicType=Nutrient&startDateLo=04-01-2023&startDateHi=11-01-2023&mimeType=csv&zip=yes&dataProfile=resultPhysChem&providers=NWIS&providers=STEWARDS&providers=STORET")
  projectProfile <- TADA::TADA_ReadWQPWebServices("https://www.waterqualitydata.us/data/Project/search?statecode=US%3A09&characteristicType=Nutrient&startDateLo=04-01-2023&startDateHi=11-01-2023&mimeType=csv&zip=yes&providers=NWIS&providers=STEWARDS&providers=STORET")

  # Join all three profiles using TADA_JoinWQPProfiles
  join <- TADA::TADA_JoinWQPProfiles(
    FullPhysChem = physchemProfile,
    Sites = stationProfile,
    Projects = projectProfile
  )

  # note that / ar replaced with . in dataRetrieval, so we also do the same in TADA_JoinWQPProfiles:
  expect_true(all(c(
    "OrganizationIdentifier",
    "OrganizationFormalName",
    "ActivityIdentifier",
    "ActivityTypeCode",
    "ActivityMediaName",
    "ActivityMediaSubdivisionName",
    "ActivityStartDate",
    "ActivityStartTime.Time",
    "VerticalAccuracyMeasure.MeasureValue",
    "VerticalAccuracyMeasure.MeasureUnitCode",
    "VerticalCollectionMethodName",
    "VerticalCoordinateReferenceSystemDatumName",
    "CountryCode",
    "StateCode",
    "CountyCode",
    "AquiferName",
    "LocalAqfrName",
    "FormationTypeText",
    "AquiferTypeName",
    "ConstructionDateText",
    "WellDepthMeasure.MeasureValue",
    "WellDepthMeasure.MeasureUnitCode",
    "WellHoleDepthMeasure.MeasureValue",
    "WellHoleDepthMeasure.MeasureUnitCode",
    "MethodSpeciationName"
  ) %in% names(join)))
})
