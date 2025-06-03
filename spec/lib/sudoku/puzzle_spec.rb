# frozen_string_literal: true

module Sudoku
  describe Puzzle do
    describe "#solved?" do
      subject { described_class.from_string(text) }

      context "failure" do
        context "incomplete" do
          let(:text) do
            <<~EOF
              453216897
              916873.42
              287945613
              728159436
              695437128
              341628759
              5793.1264
              832564971
              164792385
            EOF
          end

          it "is false" do
            expect(subject).not_to be_solved
          end
        end

        context "complete but wrong" do
          let(:text) do
            <<~EOF
              453216897
              916873542
              287945613
              728159436
              695837124
              341628759
              579381264
              832564971
              164792385
            EOF
          end

          it "is false" do
            expect(subject).not_to be_solved
          end
        end
      end

      context "success" do
        let(:text) do
          <<~EOF
            453216897
            916873542
            287945613
            728159436
            695437128
            341628759
            579381264
            832564971
            164792385
          EOF
        end

        it "is true" do
          expect(subject).to be_solved
        end
      end
    end
  end
end