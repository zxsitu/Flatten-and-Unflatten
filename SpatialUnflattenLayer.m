classdef SpatialUnflattenLayer < nnet.layer.Layer & nnet.layer.Formattable
    % SPATIALUNFLATTENLAYER  Custom layer that converts a dlarray with one
    % spatial dimension into a dlarray with two spatial dimensions.
    % This layer is intendended to be used in conjunction with
    % SpatialFlattenLayer to reconstruct the correct image dimensions.

    methods
        function layer = SpatialUnflattenLayer(opts)
           arguments
               opts.Name = "unflatten"
           end
            layer.Name = opts.Name;
        end

        function out = predict(~, in)
            % Validate the input
            if ~strcmp(dims(in), "SCB")
                error("Input must be a dlarray with one spatial, one channel, and one batch dimension");
            elseif sqrt(size(in,1)) ~= floor(sqrt(size(in,1)))
                error("Size of the spatial dimension of the input must be a square number.");
            end

            inSize = size(in);
            outSize = [sqrt(inSize(1)) sqrt(inSize(1)) inSize(2) inSize(3)];
            out = reshape(in, outSize);
            out = dlarray(out, "SSCB");
        end
    end
end