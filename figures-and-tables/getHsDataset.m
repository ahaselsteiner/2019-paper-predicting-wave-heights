function hs_sample = getHsDataset(name)
    switch name
        case 'A'
            hs_sample = double(evalin('base', 'A.Hs'));
        case 'B'
            hs_sample = double(evalin('base', 'B.Hs'));
        case 'C'
            hs_sample = double(evalin('base', 'C.Hs'));
        case 'D'
            hs_sample = double(evalin('base', 'D.Hs'));
        case 'E'
            hs_sample = double(evalin('base', 'E.Hs'));
        case 'F'
            hs_sample = double(evalin('base', 'F.Hs'));
        case 'Ar'
            hs_sample = double(evalin('base', 'Ar.Hs'));
        case 'Br'
            hs_sample = double(evalin('base', 'Br.Hs'));
        case 'Cr'
            hs_sample = double(evalin('base', 'Cr.Hs'));
        case 'Dr'
            hs_sample = double(evalin('base', 'Dr.Hs'));
        case 'Er'
            hs_sample = double(evalin('base', 'Er.Hs'));
        case 'Fr'
            hs_sample = double(evalin('base', 'Fr.Hs'));
        otherwise 
            warning('Unexpected DATA_SET.');
            return;
    end
end