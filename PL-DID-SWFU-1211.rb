#========================================================================================
#                 Copyright (C) Hospira, Inc.
#                       All rights reserved
#========================================================================================
# Notice:  All Rights Reserved.
# This material contains the trade secrets and confidential information of Hospira, Inc.,
# which embody substantial creative effort, ideas and expressions. No part of this
# material may be reproduced or transmitted in any form or by any means, electronic,
# mechanical, optical or otherwise, including photocopying and recording, or in
# connection with any information storage or retrieval system, without written permission
# from:
#
# Hospira, Inc.
# 13520 Evening Creek Dr., Suite 200
# San Diego, CA 92128
# www.hospira.com
#========================================================================================
# File: PL-DID-SWFU-1211.rb
#
# DESCRIPTION
#     This test script verifies the requirement matching the name of this file.
#
#========================================================================================
require "testutilities" #-- Contains logging & configuration functionality
require "plumapi"       #-- API for object under test

#------------------------------------
# Source any required scriptlet files
require_relative "../../../Scriptlets/GenericScriptlets.rb"
require_relative "../../../Scriptlets/NavigationScriptlets.rb"

#---------------------------------
# Define the test result constants
PASS    = "PASS"
FAIL    = "FAIL"
UNKNOWN = "UNKNOWN"

#--------------------------------
# Initialize the result variables
actualResult = []
result       = UNKNOWN

#---------------------------------
# Create an instance of TestConfig
tc = TestConfig.new

#-----------------------------------------------------------------
# Extract values from configuration file for the common parameters
LOG_PATH                 = tc.get_value_for("log-path")
POWER_ON                 = tc.get_value_for("power-on")
CONNECTION_TYPE          = tc.get_value_for("connection-type")
POWER_OFF                = tc.get_value_for("power-off")
NEW_PATIENT              = eval(tc.get_value_for("new-patient"))
CCA_NAME                 = tc.get_value_for("cca-name")
KEY_LINE                 = tc.get_value_for("key-line")
KEY_MEDICATION           = tc.get_value_for("key-medication")
KEY_SCREEN_NAME          = tc.get_value_for("key-screen-name")
KEY_INITIAL_SCREEN       = tc.get_value_for("key-initial-screen")
KEY_TARGET_SCREEN        = tc.get_value_for("key-target-screen")
MEDICATION_ML            = eval(tc.get_value_for("medication-ml"))
MEDICATION_DC            = eval(tc.get_value_for("medication-dc"))
LINE_A                   = tc.get_value_for("line-a")
LINE_B                   = tc.get_value_for("line-b")
SCREEN_NAME_S22          = tc.get_value_for("screen-name-s22")
SCREEN_NAME_S126A        = tc.get_value_for("screen-name-s126a")
SCREEN_NAME_S32_MS_MLPG1 = tc.get_value_for("screen-name-s32-ms-mlpg1")
SCREEN_NAME_S32_MS_MLPG2 = tc.get_value_for("screen-name-s32-ms-mlpg2")
SCREEN_NAME_S32_MS_DCPG1 = tc.get_value_for("screen-name-s32-ms-dcpg1")
SCREEN_NAME_S32_MS_DCPG2 = tc.get_value_for("screen-name-s32-ms-dcpg2")
SCREEN_NAME_S43_MS_MLPG1 = tc.get_value_for("screen-name-s43-ms-mlpg1")
SCREEN_NAME_S43_MS_DCPG1 = tc.get_value_for("screen-name-s43-ms-dcpg1")
SCREEN_NAME_S43_MS_MLPG2 = tc.get_value_for("screen-name-s43-ms-mlpg2")
SCREEN_NAME_S43_MS_DCPG2 = tc.get_value_for("screen-name-s43-ms-dcpg2")
RATE_VALUE               = eval(tc.get_value_for("rate-value"))
DOSE_VALUE               = eval(tc.get_value_for("dose-value"))
VTBI_VALUE               = eval(tc.get_value_for("vtbi-value"))
STEP_NUMBER_1            = tc.get_value_for("step-number-1").to_i
STEP_NUMBER_3            = tc.get_value_for("step-number-3").to_i
STEP_NUMBER_4            = tc.get_value_for("step-number-4").to_i
STEP_NUMBER_9           = tc.get_value_for("step-number-9").to_i
STEP_NUMBER_10           = tc.get_value_for("step-number-10").to_i
START_HARDKEY            = tc.get_value_for("start-hardkey")
EXPECTED_VALUE           = tc.get_value_for("expected-value").to_i
THERAPY_FORMAT_ML        = tc.get_value_for("therapy-format-ml")
THERAPY_FORMAT_DC        = tc.get_value_for("therapy-format-dc")
RATE_DOSE_FIELDS         = eval(tc.get_value_for("rate-dose-fields"))
CHECK_RATE_METHOD        = tc.get_value_for("check-rate-method")
CHECK_DOSE_METHOD        = tc.get_value_for("check-dose-method")
INITIAL_VALUE             = eval(tc.get_value_for("initial-value"))
INCREMENT_VALUE           = eval(tc.get_value_for("increment-value"))
MAX_VALUE                 = eval(tc.get_value_for("max-value"))
UP_HARDKEY                = tc.get_value_for("up-hardkey")
NAVIGATION_HASH          = eval(tc.get_value_for("navigation-hash"))

#-------------------------------------------------------
# Extract values from configuration file for test case 1
TEST_CASE_1       = tc.get_value_for("test-case-1")
EXPECTED_RESULT_1 = eval(tc.get_value_for("expected-result-1"))

#-------------------------------------------------------
# Extract values from configuration file for test case 2
TEST_CASE_2       = tc.get_value_for("test-case-2")
EXPECTED_RESULT_2 = eval(tc.get_value_for("expected-result-2"))

#-------------------------------------------------------
# Extract values from configuration file for test case 3
TEST_CASE_3       = tc.get_value_for("test-case-3")
EXPECTED_RESULT_3 = eval(tc.get_value_for("expected-result-3"))

#-------------------------------------------------------
# Extract values from configuration file for test case 4
TEST_CASE_4       = tc.get_value_for("test-case-4")
EXPECTED_RESULT_4 = eval(tc.get_value_for("expected-result-4"))

#-------------------------------------------------------
# Extract values from configuration file for test case 5
TEST_CASE_5       = tc.get_value_for("test-case-5")
EXPECTED_RESULT_5 = eval(tc.get_value_for("expected-result-5"))

#-------------------------------------------------------
# Extract values from configuration file for test case 6
TEST_CASE_6       = tc.get_value_for("test-case-6")
EXPECTED_RESULT_6 = eval(tc.get_value_for("expected-result-6"))

#-------------------------------------------------------
# Extract values from configuration file for test case 7
TEST_CASE_7       = tc.get_value_for("test-case-7")
EXPECTED_RESULT_7 = eval(tc.get_value_for("expected-result-7"))

#-------------------------------------------------------
# Extract values from configuration file for test case 8
TEST_CASE_8       = tc.get_value_for("test-case-8")
EXPECTED_RESULT_8 = eval(tc.get_value_for("expected-result-8"))

#----------------------------------
# Create the therapy type constants
NONCONTIGUOUS_ORDER = :nonContiguousOrder
CONTIGUOUS_ORDER    = :contiguousOrder

#-------------------------------
# Initialize the local variables
testCases        = []
returnValue      = []

#-------------------------------------------------------------------
# Create hashes for each test case and append in the test case array
# testCases << {:testCase           => TEST_CASE_1,
#               :lineParam          => LINE_A,
#               :medicationType     => MEDICATION_ML,
#               :programScreenPg1   => SCREEN_NAME_S32_MS_MLPG1,
#               :programScreenPg2   => SCREEN_NAME_S32_MS_MLPG2,
#               :confirmScreenPg1   => SCREEN_NAME_S43_MS_MLPG1,
#               :confirmScreenPg2   => SCREEN_NAME_S43_MS_MLPG2,
#               :checkTherapyMethod => CHECK_RATE_METHOD,
#               :editField          => RATE_DOSE_FIELDS.first,
#               :programmingOrder   => NONCONTIGUOUS_ORDER,
#               :expectedResult     => EXPECTED_RESULT_1}
testCases << {:testCase           => TEST_CASE_2,
              :lineParam          => LINE_B,
              :medicationType     => MEDICATION_ML,
              :programScreenPg1   => SCREEN_NAME_S32_MS_MLPG1,
              :programScreenPg2   => SCREEN_NAME_S32_MS_MLPG2,
              :confirmScreenPg1   => SCREEN_NAME_S43_MS_MLPG1,
              :confirmScreenPg2   => SCREEN_NAME_S43_MS_MLPG2,
              :checkTherapyMethod => CHECK_RATE_METHOD,
              :editField          => RATE_DOSE_FIELDS.first,
              :programmingOrder   => NONCONTIGUOUS_ORDER,
              :expectedResult     => EXPECTED_RESULT_2}
# testCases << {:testCase           => TEST_CASE_3,
#               :lineParam          => LINE_A,
#               :medicationType     => MEDICATION_ML,
#               :programScreenPg1   => SCREEN_NAME_S32_MS_DCPG1,
#               :programScreenPg2   => SCREEN_NAME_S32_MS_DCPG2,
#               :confirmScreenPg1   => SCREEN_NAME_S43_MS_DCPG1,
#               :confirmScreenPg2   => SCREEN_NAME_S43_MS_DCPG2,
#               :checkTherapyMethod => CHECK_DOSE_METHOD,
#               :editField          => RATE_DOSE_FIELDS.last,
#               :programmingOrder   => NONCONTIGUOUS_ORDER,
#               :expectedResult     => EXPECTED_RESULT_3}
# testCases << {:testCase           => TEST_CASE_4,
#               :lineParam          => LINE_B,
#               :medicationType     => MEDICATION_ML,
#               :programScreenPg1   => SCREEN_NAME_S32_MS_DCPG1,
#               :programScreenPg2   => SCREEN_NAME_S32_MS_DCPG2,
#               :confirmScreenPg1   => SCREEN_NAME_S43_MS_DCPG1,
#               :confirmScreenPg2   => SCREEN_NAME_S43_MS_DCPG2,
#               :checkTherapyMethod => CHECK_DOSE_METHOD,
#               :editField          => RATE_DOSE_FIELDS.last,
#               :programmingOrder   => NONCONTIGUOUS_ORDER,
#               :expectedResult     => EXPECTED_RESULT_4}
# testCases << {:testCase           => TEST_CASE_5,
#               :lineParam          => LINE_A,
#               :medicationType     => MEDICATION_ML,
#               :programScreenPg1   => SCREEN_NAME_S32_MS_MLPG1,
#               :programScreenPg2   => SCREEN_NAME_S32_MS_MLPG2,
#               :confirmScreenPg1   => SCREEN_NAME_S43_MS_MLPG1,
#               :confirmScreenPg2   => SCREEN_NAME_S43_MS_MLPG2,
#               :programmingOrder   => CONTIGUOUS_ORDER,
#               :expectedResult     => EXPECTED_RESULT_5}
# testCases << {:testCase           => TEST_CASE_6,
#               :lineParam          => LINE_B,
#               :medicationType     => MEDICATION_ML,
#               :programScreenPg1   => SCREEN_NAME_S32_MS_MLPG1,
#               :programScreenPg2   => SCREEN_NAME_S32_MS_MLPG2,
#               :confirmScreenPg1   => SCREEN_NAME_S43_MS_MLPG1,
#               :confirmScreenPg2   => SCREEN_NAME_S43_MS_MLPG2,
#               :programmingOrder   => CONTIGUOUS_ORDER,
#               :expectedResult     => EXPECTED_RESULT_6}
# testCases << {:testCase           => TEST_CASE_7,
#               :lineParam          => LINE_A,
#               :medicationType     => MEDICATION_ML,
#               :programScreenPg1   => SCREEN_NAME_S32_MS_DCPG1,
#               :programScreenPg2   => SCREEN_NAME_S32_MS_DCPG2,
#               :confirmScreenPg1   => SCREEN_NAME_S43_MS_DCPG1,
#               :confirmScreenPg2   => SCREEN_NAME_S43_MS_DCPG2,
#               :programmingOrder   => CONTIGUOUS_ORDER,
#               :expectedResult     => EXPECTED_RESULT_7}
# testCases << {:testCase           => TEST_CASE_8,
#               :lineParam          => LINE_B,
#               :medicationType     => MEDICATION_ML,
#               :programScreenPg1   => SCREEN_NAME_S32_MS_DCPG1,
#               :programScreenPg2   => SCREEN_NAME_S32_MS_DCPG2,
#               :confirmScreenPg1   => SCREEN_NAME_S43_MS_DCPG1,
#               :confirmScreenPg2   => SCREEN_NAME_S43_MS_DCPG2,
#               :programmingOrder   => CONTIGUOUS_ORDER,
#               :expectedResult     => EXPECTED_RESULT_8}

#---------------------------
# Create the output log file
tc.create_logger(LOG_PATH)
tc.report_requirement_data

#-------------------------------------------------------------------
# Create the Plum instance, power on the infuser and navigate to the
# "Main Delivery" screen (S22)
plum = PlumApi.new(tc.logger)
plum.general.set_infuser_power(POWER_ON, CONNECTION_TYPE)
s_navigate_to_main_delivery_screen(plum, NEW_PATIENT, CCA_NAME)
testCases.each do |testCase|

   tc.testcase_begin(testCase[:testCase])

   #-----------------------------------------------------------------------------------------------
   # Rate based program
   #
   # Test case 1 verifies that the Infuser System requires the steps to be programmed in sequential 
   # order for Line A.
   #
   # Test case 2 verifies that the Infuser System requires the steps to be programmed in sequential 
   # order for Line B
   #
   # Dose based program
   # Test case 3 verifies the Infuser System requires the steps to be programmed in sequential 
   # order for Line A
   #
   # Test case 4 verifies that the Infuser System requires the steps to be programmed in sequential 
   # order for Line B

   #--------------------------------------------------------
   # Assign values based on the testcase currently executing
   NAVIGATION_HASH[KEY_LINE] = testCase[:lineParam]
   NAVIGATION_HASH[KEY_MEDICATION] = testCase[:medicationType]
   therapyFormat = (testCase[:medicationType].eql? MEDICATION_ML)? THERAPY_FORMAT_ML : THERAPY_FORMAT_DC
   therapyValue = (testCase[:medicationType].eql? MEDICATION_ML)? RATE_VALUE : DOSE_VALUE

   #---------------------------------------------------------------
   # Verify that the current screen is "Main Delivery Screen" (S22)
   unless (plum.general.check_screen_id(SCREEN_NAME_S22).eql? false)

      #-------------------------------------------
      # Navigating to the Program Multistep Screen
      if (testCase[:medicationType].eql? MEDICATION_ML)
         returnValue << s_navigate_to_s32_ms_ml(plum, NAVIGATION_HASH)
      else
         returnValue << s_navigate_to_s32_ms_dc(plum, NAVIGATION_HASH)
      end
      maxSteps = (testCase[:programmingOrder].eql? NONCONTIGUOUS_ORDER)? STEP_NUMBER_9 : STEP_NUMBER_10

      #-----------------------------------------
      # Determine the max steps to be programmed
      (STEP_NUMBER_1..maxSteps).each do |stepNum|
         if (testCase[:medicationType].eql? MEDICATION_ML)
            currentProgramScreen = (stepNum <= STEP_NUMBER_3)? SCREEN_NAME_S32_MS_MLPG1 : SCREEN_NAME_S32_MS_MLPG2
         else
            currentProgramScreen = (stepNum <= STEP_NUMBER_3)? SCREEN_NAME_S32_MS_DCPG1 : SCREEN_NAME_S32_MS_DCPG2
         end
         if (testCase[:programmingOrder].eql? NONCONTIGUOUS_ORDER)
            
            #--------------------------------------------------------------------------------------------
            # Verifying that only contiguous steps can be programmed by trying to program noncontiguously
            # returnValue << eval("plum.therapy.#{testCase[:checkTherapyMethod]}(currentProgramScreen, EXPECTED_VALUE)")
            returnValue << plum.therapy.check_vtbi_value(currentProgramScreen, EXPECTED_VALUE, stepNum)
            p "setting for step #{stepNum+1} when current step is #{stepNum}"
            returnValue << (plum.therapy.set_therapy_parameters(currentProgramScreen, therapyFormat,
                                                                therapyValue, VTBI_VALUE, stepNum+1).eql? false)? true : false
            counterVal = INITIAL_VALUE
            p "desried active field #{testCase[:editField]+stepNum.to_s}"
            while (plum.general.check_active_field(currentProgramScreen, testCase[:editField]+stepNum.to_s).eql? false)
               plum.therapy.press_arrow_key(UP_HARDKEY)
               counterVal += INCREMENT_VALUE
               break if (counterVal.eql? MAX_VALUE)
            end
            p "setting correct step #{stepNum}"
            returnValue << plum.therapy.set_therapy_parameters(currentProgramScreen, therapyFormat,
                                                               therapyValue, VTBI_VALUE, stepNum)
            plum.general.press_step_4_10(currentProgramScreen) if (stepNum.eql? STEP_NUMBER_3)
         else

            #-----------------------------
            # Programming contiguous steps
            returnValue << plum.therapy.set_therapy_parameters(currentProgramScreen, therapyFormat,
                                                               therapyValue, VTBI_VALUE, stepNum)
            plum.general.press_step_4_10(currentProgramScreen) if (stepNum.eql? STEP_NUMBER_3)
         end
      end

      #------------------------------------------------------
      # Verify that all the steps are programmed contiguously
      if (testCase[:programmingOrder].eql? CONTIGUOUS_ORDER)
         returnValue << plum.therapy.check_programmed_steps_number(testCase[:programScreenPg2], STEP_NUMBER_10)
      end

      #--------------------------------------------------------------------------
      # Nil check and assign boolean value to actual result based on return value
      actualResult << ((returnValue.include? false or returnValue.include? nil or returnValue.empty?)? false : true)

      #------------------
      # Result comparison
      result = (actualResult.eql? testCase[:expectedResult])? PASS : FAIL
   else
      result = FAIL
   end

   #---------------------------------------------
   # Record the test result and end the test case
   output = plum.general.get_output_data
   tc.report_result(testCase[:testCase], output["ActualData"], output["ExpectedData"], result, output["MethodName"])
   tc.testcase_end(testCase[:testCase])

   #----------------------------------------------
   # Restricting this block for the Last test case
   unless (testCases.last.eql? testCase)

      #--------------------------------------------
      # Navigate back to Main Delivery Screen (S22)
      programScreen = (testCase[:programmingOrder].eql? CONTIGUOUS_ORDER)? testCase[:programScreenPg1] :
                                                                           testCase[:programScreenPg2]
      plum.general.press_return_ab(programScreen)
      plum.general.press_yes(SCREEN_NAME_S126A)

      #---------------------------
      # Reset the result variables
      returnValue.clear
      actualResult.clear
      result = UNKNOWN
   end
end

#---------------------
# Shutdown the Infuser
plum.general.set_infuser_power(POWER_OFF, CONNECTION_TYPE)

#-------------------------------------------------------
# Generate the test evidence and close the Plum instance
screenHash = plum.general.get_screen_hash
tc.generate_evidence_file(LOG_PATH, File.basename(__FILE__, ".rb"), screenHash)
plum.close