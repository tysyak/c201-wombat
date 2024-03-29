defmodule Wc2.Linker do
  def get_bin(assembler, assembly_path, route) do

    if route do

      file_work_wo_ext = (Path.dirname(route)<>"/"
	<>Path.basename(route, Path.extname(route)))
      asm_out = file_work_wo_ext<>".s"
      File.write!(asm_out, assembler)
      System.cmd("gcc", [asm_out, "-o"<>route])
    else
    	assembly_file_name = Path.basename(assembly_path)
	binary_file_name = Path.basename(assembly_path, ".s")
	output_dir_name = Path.dirname(assembly_path)
	assembly_path = output_dir_name <> "/" <> assembly_file_name
	
	File.write!(assembly_path, assembler)
	System.cmd("gcc", [assembly_file_name, "-o#{binary_file_name}"],
	  cd: output_dir_name)
	File.rm!(assembly_path)	
    end
  end
end
