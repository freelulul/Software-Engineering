classdef unit_test < matlab.unittest.TestCase
    
    properties
        view
        left_ele
        right_ele
        left_panel
        right_panel
        out_panel
        controller
    end
    
    methods(TestMethodSetup)
        function launchApp(tc)
            addpath("../../src");
            tc.view = UI();
            tc.left_ele = elevator();
            tc.right_ele = elevator();
            tc.left_panel = inner_panel();
            tc.right_panel = inner_panel();
            tc.out_panel = outer_panel();
            tc.controller = controler(tc.view,tc.left_ele,tc.right_ele,tc.left_panel,tc.right_panel,tc.out_panel);
        end
    end

    methods(Test)
        % T1.1.1
        function test_schedule(tc)
            tc.controller.scheduler(1);
            tc.verifyEqual(tc.controller.sig_list(1),1);
            close all force;
        end

        % T1.1.2.1
        function test_openass_1_1_2_1(tc)
            expect_ans = 1;
            fir = 1;
            c_position = [467,250];
            c_state = [3,1];
            tc.controller.hold_list(fir) = 0;
            tc.verifyEqual(tc.controller.open_close_ass(fir,c_position,c_state),expect_ans);
            close all force;
        end
        % T1.1.2.2
        function test_openass_1_1_2_2(tc)
            expect_ans = 1;
            fir = 2;
            c_position = [250,352];
            c_state = [1,3];
            tc.controller.hold_list(fir) = 1;
            tc.verifyEqual(tc.controller.open_close_ass(fir,c_position,c_state),expect_ans);
            close all force;
        end
        % T1.1.2.3
        function test_openass_1_1_2_3(tc)
            expect_ans = 1;
            fir = 4;
            c_position = [236,352];
            c_state = [5,3];
            tc.controller.sig_list(6) = 1;
            tc.controller.hold_list(fir) = 0;
            tc.verifyEqual(tc.controller.open_close_ass(fir,c_position,c_state),expect_ans);
            close all force;
        end
        % T1.1.2.4
        function test_openass_1_1_2_4(tc)
            expect_ans = 1;
            fir = 1;
            c_position = [467,352];
            c_state = [5,3];
            tc.controller.hold_list(fir) = 0;
            tc.controller.left_ele.tim = tc.controller.left_ele.open_tim;
            tc.verifyEqual(tc.controller.open_close_ass(fir,c_position,c_state),expect_ans);
            close all force;
        end
        % T1.1.2.5
        function test_openass_1_1_2_5(tc)
            expect_ans = 1;
            fir = 1;
            c_position = [467,352];
            c_state = [4,3];
            tc.controller.hold_list(fir) = 0;
            tc.verifyEqual(tc.controller.open_close_ass(fir,c_position,c_state),expect_ans);
            close all force;
        end
        % T1.1.2.6
        function test_openass_1_1_2_6(tc)
            expect_ans = 1;
            fir = 1;
            c_position = [353,467];
            c_state = [4,5];
            tc.controller.sig_list(14) = 1;
            tc.controller.hold_list(fir) = 1;
            tc.verifyEqual(tc.controller.open_close_ass(fir,c_position,c_state),expect_ans);
            close all force;
        end
        % T1.1.2.7
        function test_openass_1_1_2_7(tc)
            expect_ans = 1;
            fir = 1;
            c_position = [353,467];
            c_state = [4,5];
            tc.controller.hold_list(fir) = 1;
            tc.controller.right_ele.tim = tc.controller.right_ele.open_tim;
            tc.verifyEqual(tc.controller.open_close_ass(fir,c_position,c_state),expect_ans);
            close all force;
        end
        % T1.1.2.8
        function test_openass_1_1_2_8(tc)
            expect_ans = 1;
            fir = 1;
            c_position = [353,467];
            c_state = [3,4];
            tc.controller.hold_list(fir) = 1;
            tc.verifyEqual(tc.controller.open_close_ass(fir,c_position,c_state),expect_ans);
            close all force;
        end
        % T1.1.2.9
        function test_openass_1_1_2_9(tc)
            expect_ans = 1;
            fir = 1;
            c_position = [467,333];
            c_state = [0,4];
            tc.controller.hold_list(fir) = 0;
            tc.verifyEqual(tc.controller.open_close_ass(fir,c_position,c_state),expect_ans);
            close all force;
        end
        % T1.1.2.10
        function test_openass_1_1_2_10(tc)
            expect_ans = 1;
            fir = 1;
            c_position = [333,467];
            c_state = [1,0];
            tc.controller.hold_list(fir) = 1;
            tc.verifyEqual(tc.controller.open_close_ass(fir,c_position,c_state),expect_ans);
            close all force;
        end

        % T1.1.3.1
        function test_openass_1_1_3_1(tc)
            expect_ans = 0;
            fir = -1;
            side = 1;
            c_position = [333,467];
            c_state = [1,0];
            tc.verifyEqual(tc.controller.oneside_open_close_ass(fir,c_position,c_state,side),expect_ans);
            close all force;
        end
        % T1.1.3.2
        function test_openass_1_1_3_2(tc)
            expect_ans = 1;
            fir = 7;
            side = 1;
            c_position = [467,352];
            c_state = [3,2];
            tc.controller.hold_list(fir) = side - 1;
            tc.verifyEqual(tc.controller.oneside_open_close_ass(fir,c_position,c_state,side),expect_ans);
            close all force;
        end
        % T1.1.3.3
        function test_openass_1_1_3_3(tc)
            expect_ans = 1;
            fir = 8;
            side = 1;
            c_position = [352,236];
            c_state = [5,3];
            tc.controller.sig_list(6) = 1;
            tc.controller.hold_list(fir) = side - 1;
            tc.verifyEqual(tc.controller.oneside_open_close_ass(fir,c_position,c_state,side),expect_ans);
            close all force;
        end
        % T1.1.3.4
        function test_openass_1_1_3_4(tc)
            expect_ans = 1;
            fir = 9;
            side = 1;
            c_position = [236,352];
            c_state = [5,3];
            tc.controller.hold_list(fir) = side - 1;
            tc.controller.left_ele.tim = tc.controller.left_ele.open_tim;
            tc.verifyEqual(tc.controller.oneside_open_close_ass(fir,c_position,c_state,side),expect_ans);
            close all force;
        end
        % T1.1.3.5
        function test_openass_1_1_3_5(tc)
            expect_ans = 1;
            fir = 7;
            side = 2;
            c_position = [333,467];
            c_state = [3,5];
            tc.controller.sig_list(14) = 1;
            tc.controller.hold_list(fir) = side - 1;
            tc.verifyEqual(tc.controller.oneside_open_close_ass(fir,c_position,c_state,side),expect_ans);
            close all force;
        end
        % T1.1.3.6
        function test_openass_1_1_3_6(tc)
            expect_ans = 1;
            fir = 7;
            side = 2;
            c_position = [353,467];
            c_state = [4,5];
            tc.controller.hold_list(fir) = side - 1;
            tc.controller.right_ele.tim = tc.controller.right_ele.open_tim;
            tc.verifyEqual(tc.controller.oneside_open_close_ass(fir,c_position,c_state,side),expect_ans);
            close all force;
        end
        % T1.1.3.7
        function test_openass_1_1_3_7(tc)
            expect_ans = 1;
            fir = 7;
            side = 1;
            c_position = [467,333];
            c_state = [4,5];
            tc.controller.hold_list(fir) = side - 1;
            tc.verifyEqual(tc.controller.oneside_open_close_ass(fir,c_position,c_state,side),expect_ans);
            close all force;
        end
        % T1.1.3.8
        function test_openass_1_1_3_8(tc)
            expect_ans = 1;
            fir = 7;
            side = 1;
            c_position = [467,333];
            c_state = [0,4];
            tc.controller.hold_list(fir) = side - 1;
            tc.verifyEqual(tc.controller.oneside_open_close_ass(fir,c_position,c_state,side),expect_ans);
            close all force;
        end
        % T1.1.3.9
        function test_openass_1_1_3_9(tc)
            expect_ans = 1;
            fir = 7;
            side = 2;
            c_position = [333,467];
            c_state = [1,0];
            tc.controller.hold_list(fir) = side - 1;
            tc.verifyEqual(tc.controller.oneside_open_close_ass(fir,c_position,c_state,side),expect_ans);
            close all force;
        end

        % T1.1.4.1
        function test_openass_1_1_4_1(tc)
            expect_ans = 1;
            c_position = [352,352];
            c_state = [3,3];
            tc.controller.hold_list(2) = 0;
            tc.controller.hold_list(3) = 1;
            tc.verifyEqual(tc.controller.open_close_asstwotwo(c_position,c_state),expect_ans);
            close all force;
        end
        % T1.1.4.2
        function test_openass_1_1_4_2(tc)
            expect_ans = 1;
            c_position = [352,352];
            c_state = [5,5];
            tc.controller.hold_list(2) = 1;
            tc.controller.hold_list(3) = 0;
            tc.verifyEqual(tc.controller.open_close_asstwotwo(c_position,c_state),expect_ans);
            close all force;
        end
        % T1.1.4.3
        function test_openass_1_1_4_3(tc)
            expect_ans = 1;
            c_position = [352,352];
            c_state = [5,5];
            tc.controller.sig_list(6) = 1;
            tc.controller.sig_list(14) = 1;
            tc.controller.hold_list(2) = 0;
            tc.controller.hold_list(3) = 1;
            tc.verifyEqual(tc.controller.open_close_asstwotwo(c_position,c_state),expect_ans);
            close all force;
        end
        % T1.1.4.4
        function test_openass_1_1_4_4(tc)
            expect_ans = 1;
            c_position = [352,352];
            c_state = [5,5];
            tc.controller.sig_list(6) = 1;
            tc.controller.sig_list(14) = 1;
            tc.controller.hold_list(2) = 1;
            tc.controller.hold_list(3) = 0;
            tc.verifyEqual(tc.controller.open_close_asstwotwo(c_position,c_state),expect_ans);
            close all force;
        end
        % T1.1.4.5
        function test_openass_1_1_4_5(tc)
            expect_ans = 1;
            c_position = [352,352];
            c_state = [5,5];
            tc.controller.hold_list(2) = 0;
            tc.controller.hold_list(3) = 1;
            tc.controller.left_ele.tim = tc.controller.left_ele.open_tim;
            tc.controller.right_ele.tim = tc.controller.right_ele.open_tim;
            tc.verifyEqual(tc.controller.open_close_asstwotwo(c_position,c_state),expect_ans);
            close all force;
        end
        % T1.1.4.6
        function test_openass_1_1_4_6(tc)
            expect_ans = 0;
            c_position = [333,333];
            c_state = [1,1];
            tc.controller.hold_list(2) = 0;
            tc.controller.hold_list(3) = 1;
            tc.verifyEqual(tc.controller.open_close_asstwotwo(c_position,c_state),expect_ans);
            close all force;
        end
        % T1.1.4.7
        function test_openass_1_1_4_7(tc)
            expect_ans = 0;
            c_position = [333,352];
            c_state = [1,3];
            tc.controller.hold_list(2) = 0;
            tc.controller.hold_list(3) = 1;
            tc.verifyEqual(tc.controller.open_close_asstwotwo(c_position,c_state),expect_ans);
            close all force;
        end
        % T1.1.4.8
        function test_openass_1_1_4_8(tc)
            expect_ans = 1;
            c_position = [352,333];
            c_state = [3,1];
            tc.controller.hold_list(2) = 0;
            tc.controller.hold_list(3) = 1;
            tc.verifyEqual(tc.controller.open_close_asstwotwo(c_position,c_state),expect_ans);
            close all force;
        end
        
        % T1.1.5.1
        function test_tarmove_1_1_5_1(tc)
            expect_ans = 1;
            tar = [0,1];
            tc.controller.tar_move(tar);
            tc.verifyEqual(tc.controller.left_ele.current_state,expect_ans);
            close all force;
        end
        % T1.1.5.2
        function test_tarmove_1_1_5_2(tc)
            expect_ans = 2;
            tar = [0,2];
            tc.controller.tar_move(tar);
            tc.verifyEqual(tc.controller.left_ele.current_state,expect_ans);
            close all force;
        end
        % T1.1.5.3
        function test_tarmove_1_1_5_3(tc)
            expect_ans = 1;
            tar = [1,1];
            tc.controller.tar_move(tar);
            tc.verifyEqual(tc.controller.right_ele.current_state,expect_ans);
            close all force;
        end
        % T1.1.5.4
        function test_tarmove_1_1_5_4(tc)
            expect_ans = 2;
            tar = [1,2];
            tc.controller.tar_move(tar);
            tc.verifyEqual(tc.controller.right_ele.current_state,expect_ans);
            close all force;
        end

        % T1.1.6.1
        function test_processone_1_1_6_1(tc)
            expect_ans = 0;
            fir = 1;
            c_position = [277,277];
            c_state = [2,2];
            tc.controller.process_onesig(fir,c_position,c_state);
            tc.verifyEqual(tc.controller.right_ele.current_state,expect_ans);
            close all force;
        end

        % T1.1.7.1
        function test_processtwo_1_1_7_1(tc)
            expect_ans = 1;
            fir = 1;
            sec = 2;
            c_position = [277,277];
            c_state = [2,2];
            tc.controller.hold_list(fir) = 0;
            tc.controller.hold_list(sec) = 0;
            tc.controller.process_twosig(fir,sec,c_position,c_state);
            tc.verifyEqual(tc.controller.left_ele.current_state,expect_ans);
            close all force;
        end
        % T1.1.7.2
        function test_processtwo_1_1_7_2(tc)
            expect_ans = 0;
            fir = 1;
            sec = 2;
            c_position = [277,277];
            c_state = [2,2];
            tc.controller.hold_list(fir) = 1;
            tc.controller.hold_list(sec) = 1;
            tc.controller.process_twosig(fir,sec,c_position,c_state);
            tc.verifyEqual(tc.controller.left_ele.current_state,expect_ans);
            close all force;
        end
        % T1.1.7.3
        function test_processtwo_1_1_7_3(tc)
            expect_ans = 1;
            fir = 1;
            sec = 2;
            c_position = [467,352];
            c_state = [0,0];
            tc.controller.process_twosig(fir,sec,c_position,c_state);
            tc.verifyEqual(tc.controller.left_ele.current_state,expect_ans);
            close all force;
        end
        % T1.1.7.4
        function test_processtwo_1_1_7_4(tc)
            expect_ans = 1;
            fir = 1;
            sec = 2;
            c_position = [466,353];
            c_state = [0,0];
            tc.controller.process_twosig(fir,sec,c_position,c_state);
            tc.verifyEqual(tc.controller.left_ele.current_state,expect_ans);
            close all force;
        end

        % T1.1.8.1
        function test_processthree_1_1_8_1(tc)
            expect_ans = 1;
            fir = 1;
            sec = 2;
            thi = 3;
            c_position = [277,277];
            c_state = [2,2];
            tc.controller.hold_list(fir) = 0;
            tc.controller.hold_list(sec) = 0;
            tc.controller.hold_list(thi) = 1;
            tc.controller.process_twosig(fir,sec,c_position,c_state);
            tc.verifyEqual(tc.controller.left_ele.current_state,expect_ans);
            close all force;
        end
        % T1.1.8.2
        function test_processthree_1_1_8_2(tc)
            expect_ans = 0;
            fir = 4;
            sec = 2;
            thi = 3;
            c_position = [352,277];
            c_state = [3,2];
            tc.controller.hold_list(fir) = 0;
            tc.controller.hold_list(sec) = 1;
            tc.controller.hold_list(thi) = 1;
            tc.controller.process_twosig(fir,sec,c_position,c_state);
            tc.verifyEqual(tc.controller.left_ele.current_state,expect_ans);
            close all force;
        end
        % T1.1.8.3
        function test_processthree_1_1_8_3(tc)
            expect_ans = 1;
            fir = 1;
            sec = 2;
            thi = 3;
            c_position = [450,352];
            c_state = [1,0];
            tc.controller.hold_list(fir) = 0;
            tc.controller.hold_list(sec) = 0;
            tc.controller.hold_list(thi) = 1;
            tc.controller.process_twosig(fir,sec,c_position,c_state);
            tc.verifyEqual(tc.controller.left_ele.current_state,expect_ans);
            close all force;
        end
        % T1.1.8.4
        function test_processthree_1_1_8_4(tc)
            expect_ans = 1;
            fir = 1;
            sec = 3;
            thi = 4;
            c_position = [236,450];
            c_state = [2,2];
            tc.controller.hold_list(fir) = 0;
            tc.controller.hold_list(sec) = 1;
            tc.controller.hold_list(thi) = 1;
            tc.controller.process_twosig(fir,sec,c_position,c_state);
            tc.verifyEqual(tc.controller.left_ele.current_state,expect_ans);
            close all force;
        end
        % T1.1.8.5
        function test_processthree_1_1_8_5(tc)
            expect_ans = 1;
            fir = 2;
            sec = 3;
            thi = 4;
            c_position = [236,236];
            c_state = [1,1];
            tc.controller.hold_list(fir) = 0;
            tc.controller.hold_list(sec) = 0;
            tc.controller.hold_list(thi) = 1;
            tc.controller.process_twosig(fir,sec,c_position,c_state);
            tc.verifyEqual(tc.controller.left_ele.current_state,expect_ans);
            close all force;
        end
        % T1.1.8.6
        function test_processthree_1_1_8_6(tc)
            expect_ans = 1;
            fir = 2;
            sec = 3;
            thi = 4;
            c_position = [467,467];
            c_state = [2,2];
            tc.controller.hold_list(fir) = 0;
            tc.controller.hold_list(sec) = 1;
            tc.controller.hold_list(thi) = 1;
            tc.controller.process_threesig(fir,sec,thi,c_position,c_state);
            tc.verifyEqual(tc.controller.left_ele.current_state,expect_ans);
            close all force;
        end
        
        % T1.1.9.1
        function test_out_hanone_1_1_9_1(tc)
            expect_ans = 0;
            side = 1;
            out_sig = [0,0,0,0,0];
            c_position = [236,467];
            c_state = [1,2];
            tc.controller.hold_list(1) = -1;
            tc.controller.hold_list(2) = -1;
            tc.controller.hold_list(3) = -1;
            tc.controller.hold_list(4) = -1;
            tc.controller.outer_handle_oneside(side,out_sig,c_position,c_state);
            tc.verifyEqual(tc.controller.left_ele.current_state,expect_ans);
            close all force;
        end
        % T1.1.9.2
        function test_out_hanone_1_1_9_2(tc)
            expect_ans = 1;
            side = 1;
            out_sig = [1,0,1,0,0];
            c_position = [352,467];
            c_state = [2,2];
            tc.controller.hold_list(1) = 0;
            tc.controller.hold_list(2) = -1;
            tc.controller.hold_list(3) = -1;
            tc.controller.hold_list(4) = -1;
            tc.controller.outer_handle_oneside(side,out_sig,c_position,c_state);
            tc.verifyEqual(tc.controller.left_ele.current_state,expect_ans);
            close all force;
        end
        % T1.1.9.3
        function test_out_hanone_1_1_9_3(tc)
            expect_ans = 0;
            side = 2;
            out_sig = [0,0,0,1,0];
            c_position = [236,467];
            c_state = [1,2];
            tc.controller.hold_list(1) = -1;
            tc.controller.hold_list(2) = 1;
            tc.controller.hold_list(3) = -1;
            tc.controller.hold_list(4) = -1;
            tc.controller.outer_handle_oneside(side,out_sig,c_position,c_state);
            tc.verifyEqual(tc.controller.left_ele.current_state,expect_ans);
            close all force;
        end
        % T1.1.9.4
        function test_out_hanone_1_1_9_4(tc)
            expect_ans = 0;
            side = 2;
            out_sig = [0,1,0,0,1];
            c_position = [236,467];
            c_state = [1,2];
            tc.controller.hold_list(1) = -1;
            tc.controller.hold_list(2) = 0;
            tc.controller.hold_list(3) = -1;
            tc.controller.hold_list(4) = 1;
            tc.controller.outer_handle_oneside(side,out_sig,c_position,c_state);
            tc.verifyEqual(tc.controller.left_ele.current_state,expect_ans);
            close all force;
        end
        % T1.1.9.5
        function test_out_hanone_1_1_9_5(tc)
            expect_ans = 3;
            side = 1;
            out_sig = [1,1,0,0,0];
            c_position = [352,352];
            c_state = [0,1];
            tc.controller.hold_list(1) = 0;
            tc.controller.hold_list(2) = 0;
            tc.controller.hold_list(3) = -1;
            tc.controller.hold_list(4) = -1;
            tc.controller.outer_handle_oneside(side,out_sig,c_position,c_state);
            tc.verifyEqual(tc.controller.left_ele.current_state,expect_ans);
            close all force;
        end
        % T1.1.9.6
        function test_out_hanone_1_1_9_6(tc)
            expect_ans = 1;
            side = 1;
            out_sig = [0,1,1,0,0];
            c_position = [236,352];
            c_state = [0,1];
            tc.controller.hold_list(1) = 0;
            tc.controller.hold_list(2) = -1;
            tc.controller.hold_list(3) = 1;
            tc.controller.hold_list(4) = -1;
            tc.controller.outer_handle_oneside(side,out_sig,c_position,c_state);
            tc.verifyEqual(tc.controller.left_ele.current_state,expect_ans);
            close all force;
        end
        % T1.1.9.7
        function test_out_hanone_1_1_9_7(tc)
            expect_ans = 0;
            side = 2;
            out_sig = [1,0,0,0,1];
            c_position = [236,467];
            c_state = [2,2];
            tc.controller.hold_list(1) = 1;
            tc.controller.hold_list(2) = 0;
            tc.controller.hold_list(3) = -1;
            tc.controller.hold_list(4) = -1;
            tc.controller.outer_handle_oneside(side,out_sig,c_position,c_state);
            tc.verifyEqual(tc.controller.left_ele.current_state,expect_ans);
            close all force;
        end
        % T1.1.9.8
        function test_out_hanone_1_1_9_8(tc)
            expect_ans = 1;
            side = 1;
            out_sig = [1,1,1,0,0];
            c_position = [352,236];
            c_state = [2,1];
            tc.controller.hold_list(1) = 0;
            tc.controller.hold_list(2) = 0;
            tc.controller.hold_list(3) = 1;
            tc.controller.hold_list(4) = -1;
            tc.controller.outer_handle_oneside(side,out_sig,c_position,c_state);
            tc.verifyEqual(tc.controller.left_ele.current_state,expect_ans);
            close all force;
        end

        % T1.1.10.1
        function test_choosehold_1_1_10_1(tc)
            a = 1;
            b = 2;
            side = 0;
            expect_ans = b;
            tc.controller.hold_list(a) = side;
            tc.verifyEqual(tc.controller.choose_hold(a,b,side),expect_ans);
            close all force;
        end
        % T1.1.10.2
        function test_choosehold_1_1_10_2(tc)
            a = 1;
            b = 2;
            side = 1;
            expect_ans = a;
            tc.controller.hold_list(b) = side;
            tc.verifyEqual(tc.controller.choose_hold(a,b,side),expect_ans);
            close all force;
        end

        % T1.1.11.1
        function test_update_1_1_11_1(tc)
            for i = 5:9
                tc.controller.sig_list(i) = 0;
            end
            for i = 1:14
                tc.controller.hold_list(i) = 0;
            end
            expect_ans = 0;
            tc.controller.update_all();
            tc.verifyEqual(tc.controller.left_inner_p.whether_havesig,expect_ans);
            close all force;
        end
        % T1.1.11.2
        function test_update_1_1_11_2(tc)
            for i = 10:14
                tc.controller.sig_list(i) = 1;
            end
            for i = 1:14
                tc.controller.hold_list(i) = 1;
            end
            expect_ans = 1;
            tc.controller.update_all();
            tc.verifyEqual(tc.controller.right_inner_p.whether_havesig,expect_ans);
            close all force;
        end
        % T1.1.11.3
        function test_update_1_1_11_3(tc)
            for i = 1:14
                tc.controller.hold_list(i) = 1;
            end
            expect_ans = 0;
            tc.controller.update_all();
            tc.verifyEqual(tc.controller.left_inner_p.whether_havesig,expect_ans);
            close all force;
        end

        % T1.2.1
        function test_ass_leftget_1_2_1(tc)
            expect_ans = 1;
            tc.controller.hold_list(1) = 0;
            tc.verifyEqual(tc.controller.ass_leftget(),expect_ans);
            close all force;
        end

        % T1.2.2
        function test_ass_rightget_1_2_2(tc)
            expect_ans = 1;
            tc.controller.hold_list(1) = 1;
            tc.verifyEqual(tc.controller.ass_rightget(),expect_ans);
            close all force;
        end

        % T1.3.1
        function test_delete_timer_1_3_1(tc)
            tc.controller.delete_timer();
            tc.verifyEmpty(tc.controller.flush);
            close all force;
        end

    end
end

