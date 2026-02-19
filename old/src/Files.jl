function parser(filepath::String; numberoffields::Int = 8)
    
    # initialize -
    records = Dict{Int, Array{Float64, 1}}();
    labels = Array{Float64, 1}();
    
    # open the file, process each line -
    linecounter = 1;
    open(filepath, "r") do io # open a stream to the file
        for line ∈ eachline(io)
            
            # fields -
            fields = split(line, " ");
            y = parse(Float64, fields[1]) # first field is the label

            # split around the : character -
            record = Dict{Int, Float64}();
            for field ∈ fields[2:end]
                key, value = split(field, ":");
                key = parse(Int, key);
                value = parse(Float64, value);
                record[key] = value;
            end

            # store the record -
            records[linecounter] = [record[i] for i ∈ 1:numberoffields];
            push!(labels, y);
            linecounter += 1;
        end
    end

    # convert records to an array -
    recordarray = hcat(values(records)...) |> transpose |> Matrix;


    return [recordarray labels];
end