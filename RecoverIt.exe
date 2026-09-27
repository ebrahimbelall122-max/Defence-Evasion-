#include <windows.h>
#include <string>
#include <iostream>

bool SetServiceFailureRunProgram(std::wstring serviceName,std::wstring programPath,std::wstring arguments)
{
    SC_HANDLE hSCM = OpenSCManager(nullptr, nullptr, SC_MANAGER_ALL_ACCESS);
    if (!hSCM) 
    {
        std::wcerr << L"OpenSCManager failed. Error: " << GetLastError() << std::endl;
        return false;
    }
    SC_HANDLE hService = OpenService(hSCM, serviceName.c_str(), SERVICE_CHANGE_CONFIG);
    if (!hService) 
    {
        std::wcerr << L"OpenService failed. Error: " << GetLastError() << std::endl;
        CloseServiceHandle(hSCM);
        return false;
    }
    std::wstring commandLine = programPath;
    if (!arguments.empty()) 
    {
        commandLine += L" ";
        commandLine += arguments;
    }
    SC_ACTION actions[1];
    actions[0].Type = SC_ACTION_RUN_COMMAND;
    actions[0].Delay = 0; // no delay

    SERVICE_FAILURE_ACTIONS sfa = {};
    sfa.dwResetPeriod = 0; // reset failure count never
    sfa.lpRebootMsg = nullptr;
    sfa.lpCommand = const_cast<LPWSTR>(commandLine.c_str());
    sfa.cActions = 1;
    sfa.lpsaActions = actions;

    BOOL success = ChangeServiceConfig2(hService, SERVICE_CONFIG_FAILURE_ACTIONS, &sfa);
    if (!success) 
    {
        std::wcerr << L"ChangeServiceConfig2 failed. Error: " << GetLastError() << std::endl;
    }
    else
    {
        std::wcout << L"Service failure action updated successfully." << std::endl;
    }

    SERVICE_FAILURE_ACTIONS_FLAG flag = {}; 
    flag.fFailureActionsOnNonCrashFailures = TRUE; 
    success = ChangeServiceConfig2(hService, SERVICE_CONFIG_FAILURE_ACTIONS_FLAG, &flag); 
    if (!success) 
    { 
        std::wcerr << L"ChangeServiceConfig2 (FAILURE_ACTIONS_FLAG) failed. Error: " << GetLastError() << std::endl; 
    }
    else
    { 
        std::wcout << L"Service recovery configured successfully (including stop with errors)." << std::endl; 
    }

    CloseServiceHandle(hService);
    CloseServiceHandle(hSCM);
    return success == TRUE;
}

int wmain(int argc, wchar_t* argv[])
{
    std::wcout << L"\nRecoverIt: Change Windows Service Recovery\n"
        << L"\nGitHub: https://github.com/TwoSevenOneT/RecoverIt\n"
        << L"\nTwo Seven One Three: https://x.com/TwoSevenOneT\n"
        << L"\n==========================================================\n\n";

    if (argc < 3) 
    {
        std::wcerr << L"Usage: RecoverIt <ServiceName> <ProgramPath> [Arguments]" << std::endl;
        return 1;
    }

    std::wstring serviceName = argv[1];
    std::wstring programPath = argv[2];
    std::wstring arguments;

    if (argc > 3) 
    {
        for (int i = 3; i < argc; ++i) 
        {
            if (!arguments.empty()) arguments += L" ";
            arguments += argv[i];
        }
    }

    if (!SetServiceFailureRunProgram(serviceName, programPath, arguments)) 
    {
        return 1;
    }
    return 0;
}
