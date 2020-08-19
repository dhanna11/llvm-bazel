# This file is licensed under the Apache License v2.0 with LLVM Exceptions.
# See https://llvm.org/LICENSE.txt for license information.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
#
# This BUILD file is auto-generated; do not edit!
# See generate_bazel_build.py

load(
    "//llvm:llvm.bzl",
    "cmake_var_string",
    "expand_cmake_vars",
    "gentbl",
    "llvm_all_cmake_vars",
    "llvm_copts",
    "llvm_defines",
    "llvm_linkopts",
    "llvm_support_platform_specific_srcs_glob",
)
load(
    "//llvm:template_rule.bzl",
    "template_rule",
)

package(
    default_visibility = ["//visibility:public"],
    licenses = ["notice"],
)

exports_files(["LICENSE.TXT"])

llvm_host_triple = "x86_64-unknown-linux_gnu"

llvm_targets = [
    "AArch64",
    "AMDGPU",
    "ARM",
    "NVPTX",
    "PowerPC",
    "SystemZ",
    "X86",
]

py_binary(
    name = "expand_cmake_vars",
    srcs = ["expand_cmake_vars.py"],
    srcs_version = "PY2AND3",
    visibility = ["@llvm-project//:__subpackages__"],
)

llvm_target_asm_parsers = llvm_targets

llvm_target_asm_printers = llvm_targets

llvm_target_disassemblers = llvm_targets

# Performs CMake variable substitutions on configuration header files.
expand_cmake_vars(
    name = "config_gen",
    src = "include/llvm/Config/config.h.cmake",
    cmake_vars = llvm_all_cmake_vars,
    dst = "include/llvm/Config/config.h",
)

expand_cmake_vars(
    name = "llvm_config_gen",
    src = "include/llvm/Config/llvm-config.h.cmake",
    cmake_vars = llvm_all_cmake_vars,
    dst = "include/llvm/Config/llvm-config.h",
)

expand_cmake_vars(
    name = "abi_breaking_gen",
    src = "include/llvm/Config/abi-breaking.h.cmake",
    cmake_vars = llvm_all_cmake_vars,
    dst = "include/llvm/Config/abi-breaking.h",
)

# Performs macro expansions on .def.in files
template_rule(
    name = "targets_def_gen",
    src = "include/llvm/Config/Targets.def.in",
    out = "include/llvm/Config/Targets.def",
    substitutions = {
        "@LLVM_ENUM_TARGETS@": "\n".join(
            ["LLVM_TARGET({})".format(t) for t in llvm_targets],
        ),
    },
)

template_rule(
    name = "asm_parsers_def_gen",
    src = "include/llvm/Config/AsmParsers.def.in",
    out = "include/llvm/Config/AsmParsers.def",
    substitutions = {
        "@LLVM_ENUM_ASM_PARSERS@": "\n".join(
            ["LLVM_ASM_PARSER({})".format(t) for t in llvm_target_asm_parsers],
        ),
    },
)

template_rule(
    name = "asm_printers_def_gen",
    src = "include/llvm/Config/AsmPrinters.def.in",
    out = "include/llvm/Config/AsmPrinters.def",
    substitutions = {
        "@LLVM_ENUM_ASM_PRINTERS@": "\n".join(
            ["LLVM_ASM_PRINTER({})".format(t) for t in llvm_target_asm_printers],
        ),
    },
)

template_rule(
    name = "disassemblers_def_gen",
    src = "include/llvm/Config/Disassemblers.def.in",
    out = "include/llvm/Config/Disassemblers.def",
    substitutions = {
        "@LLVM_ENUM_DISASSEMBLERS@": "\n".join(
            ["LLVM_DISASSEMBLER({})".format(t) for t in llvm_target_disassemblers],
        ),
    },
)

# A common library that all LLVM targets depend on.
# TODO(b/113996071): We need to glob all potentially #included files and stage
# them here because LLVM's build files are not strict headers clean, and remote
# build execution requires all inputs to be depended upon.
cc_library(
    name = "config",
    hdrs = glob([
        "**/*.h",
        "**/*.def",
        "**/*.inc.cpp",
    ]) + [
        "include/llvm/Config/AsmParsers.def",
        "include/llvm/Config/AsmPrinters.def",
        "include/llvm/Config/Disassemblers.def",
        "include/llvm/Config/Targets.def",
        "include/llvm/Config/config.h",
        "include/llvm/Config/llvm-config.h",
        "include/llvm/Config/abi-breaking.h",
    ],
    defines = llvm_defines,
    includes = ["include"],
)

# A creator of an empty file include/llvm/Support/VCSRevision.h.
# This is usually populated by the upstream build infrastructure, but in this
# case we leave it blank. See upstream revision r300160.
genrule(
    name = "vcs_revision_gen",
    srcs = [],
    outs = ["include/llvm/Support/VCSRevision.h"],
    cmd = "echo '' > \"$@\"",
)

# Rules that apply the LLVM tblgen tool.
gentbl(
    name = "attributes_gen",
    tbl_outs = [("-gen-attrs", "include/llvm/IR/Attributes.inc")],
    tblgen = ":llvm-tblgen",
    td_file = "include/llvm/IR/Attributes.td",
    td_srcs = ["include/llvm/IR/Attributes.td"],
)

gentbl(
    name = "InstCombineTableGen",
    tbl_outs = [(
        "-gen-searchable-tables",
        "lib/Target/AMDGPU/InstCombineTables.inc",
    )],
    tblgen = ":llvm-tblgen",
    td_file = "lib/Target/AMDGPU/InstCombineTables.td",
    td_srcs = glob([
        "include/llvm/CodeGen/*.td",
        "include/llvm/IR/Intrinsics*.td",
    ]) + ["include/llvm/TableGen/SearchableTable.td"],
)

gentbl(
    name = "intrinsic_enums_gen",
    tbl_outs = [("-gen-intrinsic-enums", "include/llvm/IR/IntrinsicEnums.inc")],
    tblgen = ":llvm-tblgen",
    td_file = "include/llvm/IR/Intrinsics.td",
    td_srcs = glob([
        "include/llvm/CodeGen/*.td",
        "include/llvm/IR/Intrinsics*.td",
    ]),
)

gentbl(
    name = "aarch64_enums_gen",
    tbl_outs = [(
        "-gen-intrinsic-enums -intrinsic-prefix=aarch64",
        "include/llvm/IR/IntrinsicsAArch64.h",
    )],
    tblgen = ":llvm-tblgen",
    td_file = "include/llvm/IR/Intrinsics.td",
    td_srcs = glob([
        "include/llvm/CodeGen/*.td",
        "include/llvm/IR/Intrinsics*.td",
    ]),
)

gentbl(
    name = "amdgcn_enums_gen",
    tbl_outs = [(
        "-gen-intrinsic-enums -intrinsic-prefix=amdgcn",
        "include/llvm/IR/IntrinsicsAMDGPU.h",
    )],
    tblgen = ":llvm-tblgen",
    td_file = "include/llvm/IR/Intrinsics.td",
    td_srcs = glob([
        "include/llvm/CodeGen/*.td",
        "include/llvm/IR/Intrinsics*.td",
    ]),
)

gentbl(
    name = "arm_enums_gen",
    tbl_outs = [(
        "-gen-intrinsic-enums -intrinsic-prefix=arm",
        "include/llvm/IR/IntrinsicsARM.h",
    )],
    tblgen = ":llvm-tblgen",
    td_file = "include/llvm/IR/Intrinsics.td",
    td_srcs = glob([
        "include/llvm/CodeGen/*.td",
        "include/llvm/IR/Intrinsics*.td",
    ]),
)

gentbl(
    name = "bpf_enums_gen",
    tbl_outs = [(
        "-gen-intrinsic-enums -intrinsic-prefix=bpf",
        "include/llvm/IR/IntrinsicsBPF.h",
    )],
    tblgen = ":llvm-tblgen",
    td_file = "include/llvm/IR/Intrinsics.td",
    td_srcs = glob([
        "include/llvm/CodeGen/*.td",
        "include/llvm/IR/Intrinsics*.td",
    ]),
)

gentbl(
    name = "hexagon_enums_gen",
    tbl_outs = [(
        "-gen-intrinsic-enums -intrinsic-prefix=hexagon",
        "include/llvm/IR/IntrinsicsHexagon.h",
    )],
    tblgen = ":llvm-tblgen",
    td_file = "include/llvm/IR/Intrinsics.td",
    td_srcs = glob([
        "include/llvm/CodeGen/*.td",
        "include/llvm/IR/Intrinsics*.td",
    ]),
)

gentbl(
    name = "mips_enums_gen",
    tbl_outs = [(
        "-gen-intrinsic-enums -intrinsic-prefix=mips",
        "include/llvm/IR/IntrinsicsMips.h",
    )],
    tblgen = ":llvm-tblgen",
    td_file = "include/llvm/IR/Intrinsics.td",
    td_srcs = glob([
        "include/llvm/CodeGen/*.td",
        "include/llvm/IR/Intrinsics*.td",
    ]),
)

gentbl(
    name = "nvvm_enums_gen",
    tbl_outs = [(
        "-gen-intrinsic-enums -intrinsic-prefix=nvvm",
        "include/llvm/IR/IntrinsicsNVPTX.h",
    )],
    tblgen = ":llvm-tblgen",
    td_file = "include/llvm/IR/Intrinsics.td",
    td_srcs = glob([
        "include/llvm/CodeGen/*.td",
        "include/llvm/IR/Intrinsics*.td",
    ]),
)

gentbl(
    name = "ppc_enums_gen",
    tbl_outs = [(
        "-gen-intrinsic-enums -intrinsic-prefix=ppc",
        "include/llvm/IR/IntrinsicsPowerPC.h",
    )],
    tblgen = ":llvm-tblgen",
    td_file = "include/llvm/IR/Intrinsics.td",
    td_srcs = glob([
        "include/llvm/CodeGen/*.td",
        "include/llvm/IR/Intrinsics*.td",
    ]),
)

gentbl(
    name = "r600_enums_gen",
    tbl_outs = [(
        "-gen-intrinsic-enums -intrinsic-prefix=r600",
        "include/llvm/IR/IntrinsicsR600.h",
    )],
    tblgen = ":llvm-tblgen",
    td_file = "include/llvm/IR/Intrinsics.td",
    td_srcs = glob([
        "include/llvm/CodeGen/*.td",
        "include/llvm/IR/Intrinsics*.td",
    ]),
)

gentbl(
    name = "riscv_enums_gen",
    tbl_outs = [(
        "-gen-intrinsic-enums -intrinsic-prefix=riscv",
        "include/llvm/IR/IntrinsicsRISCV.h",
    )],
    tblgen = ":llvm-tblgen",
    td_file = "include/llvm/IR/Intrinsics.td",
    td_srcs = glob([
        "include/llvm/CodeGen/*.td",
        "include/llvm/IR/Intrinsics*.td",
    ]),
)

gentbl(
    name = "s390_enums_gen",
    tbl_outs = [(
        "-gen-intrinsic-enums -intrinsic-prefix=s390",
        "include/llvm/IR/IntrinsicsS390.h",
    )],
    tblgen = ":llvm-tblgen",
    td_file = "include/llvm/IR/Intrinsics.td",
    td_srcs = glob([
        "include/llvm/CodeGen/*.td",
        "include/llvm/IR/Intrinsics*.td",
    ]),
)

gentbl(
    name = "wasm_enums_gen",
    tbl_outs = [(
        "-gen-intrinsic-enums -intrinsic-prefix=wasm",
        "include/llvm/IR/IntrinsicsWebAssembly.h",
    )],
    tblgen = ":llvm-tblgen",
    td_file = "include/llvm/IR/Intrinsics.td",
    td_srcs = glob([
        "include/llvm/CodeGen/*.td",
        "include/llvm/IR/Intrinsics*.td",
    ]),
)

gentbl(
    name = "x86_enums_gen",
    tbl_outs = [(
        "-gen-intrinsic-enums -intrinsic-prefix=x86",
        "include/llvm/IR/IntrinsicsX86.h",
    )],
    tblgen = ":llvm-tblgen",
    td_file = "include/llvm/IR/Intrinsics.td",
    td_srcs = glob([
        "include/llvm/CodeGen/*.td",
        "include/llvm/IR/Intrinsics*.td",
    ]),
)

gentbl(
    name = "xcore_enums_gen",
    tbl_outs = [(
        "-gen-intrinsic-enums -intrinsic-prefix=xcore",
        "include/llvm/IR/IntrinsicsXCore.h",
    )],
    tblgen = ":llvm-tblgen",
    td_file = "include/llvm/IR/Intrinsics.td",
    td_srcs = glob([
        "include/llvm/CodeGen/*.td",
        "include/llvm/IR/Intrinsics*.td",
    ]),
)

gentbl(
    name = "intrinsics_impl_gen",
    tbl_outs = [("-gen-intrinsic-impl", "include/llvm/IR/IntrinsicImpl.inc")],
    tblgen = ":llvm-tblgen",
    td_file = "include/llvm/IR/Intrinsics.td",
    td_srcs = glob([
        "include/llvm/CodeGen/*.td",
        "include/llvm/IR/Intrinsics*.td",
    ]),
)

cc_library(
    name = "tblgen",
    srcs = glob([
        "utils/TableGen/*.cpp",
        "utils/TableGen/*.h",
        "utils/TableGen/GlobalISel/*.cpp",
    ]),
    hdrs = glob([
        "utils/TableGen/GlobalISel/*.h",
    ]),
    deps = [
        ":MC",
        ":Support",
        ":TableGen",
        ":config",
    ],
)

# Binary targets used by Tensorflow.
cc_binary(
    name = "llvm-tblgen",
    srcs = glob([
        "utils/TableGen/*.cpp",
        "utils/TableGen/*.h",
    ]),
    copts = llvm_copts,
    linkopts = llvm_linkopts,
    stamp = 0,
    deps = [
        ":Support",
        ":TableGen",
        ":config",
        ":tblgen",
    ],
)

cc_binary(
    name = "FileCheck",
    testonly = 1,
    srcs = glob([
        "utils/FileCheck/*.cpp",
        "utils/FileCheck/*.h",
    ]),
    copts = llvm_copts,
    linkopts = llvm_linkopts,
    stamp = 0,
    deps = [":Support"],
)

llvm_target_list = [
    {
        "name": "AArch64",
        "lower_name": "aarch64",
        "short_name": "AArch64",
        "dir_name": "AArch64",
        "tbl_outs": [
            ("-gen-register-bank", "lib/Target/AArch64/AArch64GenRegisterBank.inc"),
            ("-gen-register-info", "lib/Target/AArch64/AArch64GenRegisterInfo.inc"),
            ("-gen-instr-info", "lib/Target/AArch64/AArch64GenInstrInfo.inc"),
            ("-gen-emitter", "lib/Target/AArch64/AArch64GenMCCodeEmitter.inc"),
            ("-gen-pseudo-lowering", "lib/Target/AArch64/AArch64GenMCPseudoLowering.inc"),
            ("-gen-asm-writer", "lib/Target/AArch64/AArch64GenAsmWriter.inc"),
            ("-gen-asm-writer -asmwriternum=1", "lib/Target/AArch64/AArch64GenAsmWriter1.inc"),
            ("-gen-asm-matcher", "lib/Target/AArch64/AArch64GenAsmMatcher.inc"),
            ("-gen-dag-isel", "lib/Target/AArch64/AArch64GenDAGISel.inc"),
            ("-gen-fast-isel", "lib/Target/AArch64/AArch64GenFastISel.inc"),
            ("-gen-global-isel", "lib/Target/AArch64/AArch64GenGlobalISel.inc"),
            ("-gen-global-isel-combiner -combiners=AArch64PreLegalizerCombinerHelper", "lib/Target/AArch64/AArch64GenPreLegalizeGICombiner.inc"),
            ("-gen-global-isel-combiner -combiners=AArch64PostLegalizerCombinerHelper", "lib/Target/AArch64/AArch64GenPostLegalizeGICombiner.inc"),
            ("-gen-callingconv", "lib/Target/AArch64/AArch64GenCallingConv.inc"),
            ("-gen-subtarget", "lib/Target/AArch64/AArch64GenSubtargetInfo.inc"),
            ("-gen-disassembler", "lib/Target/AArch64/AArch64GenDisassemblerTables.inc"),
            ("-gen-searchable-tables", "lib/Target/AArch64/AArch64GenSystemOperands.inc"),
        ],
    },
    {
        "name": "AMDGPU",
        "lower_name": "amdgpu",
        "short_name": "AMDGPU",
        "dir_name": "AMDGPU",
        "tbl_outs": [
            ("-gen-register-bank", "lib/Target/AMDGPU/AMDGPUGenRegisterBank.inc"),
            ("-gen-register-info", "lib/Target/AMDGPU/AMDGPUGenRegisterInfo.inc"),
            ("-gen-instr-info", "lib/Target/AMDGPU/AMDGPUGenInstrInfo.inc"),
            ("-gen-emitter", "lib/Target/AMDGPU/AMDGPUGenMCCodeEmitter.inc"),
            ("-gen-pseudo-lowering", "lib/Target/AMDGPU/AMDGPUGenMCPseudoLowering.inc"),
            ("-gen-asm-writer", "lib/Target/AMDGPU/AMDGPUGenAsmWriter.inc"),
            ("-gen-asm-matcher", "lib/Target/AMDGPU/AMDGPUGenAsmMatcher.inc"),
            ("-gen-dag-isel", "lib/Target/AMDGPU/AMDGPUGenDAGISel.inc"),
            ("-gen-callingconv", "lib/Target/AMDGPU/AMDGPUGenCallingConv.inc"),
            ("-gen-subtarget", "lib/Target/AMDGPU/AMDGPUGenSubtargetInfo.inc"),
            ("-gen-disassembler", "lib/Target/AMDGPU/AMDGPUGenDisassemblerTables.inc"),
            ("-gen-searchable-tables", "lib/Target/AMDGPU/AMDGPUGenSearchableTables.inc"),
        ],
        "tbl_deps": [
            ":amdgpu_isel_target_gen",
        ],
    },
    {
        "name": "ARM",
        "lower_name": "arm",
        "short_name": "ARM",
        "dir_name": "ARM",
        "tbl_outs": [
            ("-gen-register-bank", "lib/Target/ARM/ARMGenRegisterBank.inc"),
            ("-gen-register-info", "lib/Target/ARM/ARMGenRegisterInfo.inc"),
            ("-gen-searchable-tables", "lib/Target/ARM/ARMGenSystemRegister.inc"),
            ("-gen-instr-info", "lib/Target/ARM/ARMGenInstrInfo.inc"),
            ("-gen-emitter", "lib/Target/ARM/ARMGenMCCodeEmitter.inc"),
            ("-gen-pseudo-lowering", "lib/Target/ARM/ARMGenMCPseudoLowering.inc"),
            ("-gen-asm-writer", "lib/Target/ARM/ARMGenAsmWriter.inc"),
            ("-gen-asm-matcher", "lib/Target/ARM/ARMGenAsmMatcher.inc"),
            ("-gen-dag-isel", "lib/Target/ARM/ARMGenDAGISel.inc"),
            ("-gen-fast-isel", "lib/Target/ARM/ARMGenFastISel.inc"),
            ("-gen-global-isel", "lib/Target/ARM/ARMGenGlobalISel.inc"),
            ("-gen-callingconv", "lib/Target/ARM/ARMGenCallingConv.inc"),
            ("-gen-subtarget", "lib/Target/ARM/ARMGenSubtargetInfo.inc"),
            ("-gen-disassembler", "lib/Target/ARM/ARMGenDisassemblerTables.inc"),
        ],
    },
    {
        "name": "NVPTX",
        "lower_name": "nvptx",
        "short_name": "NVPTX",
        "dir_name": "NVPTX",
        "tbl_outs": [
            ("-gen-register-info", "lib/Target/NVPTX/NVPTXGenRegisterInfo.inc"),
            ("-gen-instr-info", "lib/Target/NVPTX/NVPTXGenInstrInfo.inc"),
            ("-gen-asm-writer", "lib/Target/NVPTX/NVPTXGenAsmWriter.inc"),
            ("-gen-dag-isel", "lib/Target/NVPTX/NVPTXGenDAGISel.inc"),
            ("-gen-subtarget", "lib/Target/NVPTX/NVPTXGenSubtargetInfo.inc"),
        ],
    },
    {
        "name": "PowerPC",
        "lower_name": "powerpc",
        "short_name": "PPC",
        "dir_name": "PowerPC",
        "tbl_outs": [
            ("-gen-asm-writer", "lib/Target/PowerPC/PPCGenAsmWriter.inc"),
            ("-gen-asm-matcher", "lib/Target/PowerPC/PPCGenAsmMatcher.inc"),
            ("-gen-emitter", "lib/Target/PowerPC/PPCGenMCCodeEmitter.inc"),
            ("-gen-register-info", "lib/Target/PowerPC/PPCGenRegisterInfo.inc"),
            ("-gen-instr-info", "lib/Target/PowerPC/PPCGenInstrInfo.inc"),
            ("-gen-dag-isel", "lib/Target/PowerPC/PPCGenDAGISel.inc"),
            ("-gen-fast-isel", "lib/Target/PowerPC/PPCGenFastISel.inc"),
            ("-gen-callingconv", "lib/Target/PowerPC/PPCGenCallingConv.inc"),
            ("-gen-subtarget", "lib/Target/PowerPC/PPCGenSubtargetInfo.inc"),
            ("-gen-disassembler", "lib/Target/PowerPC/PPCGenDisassemblerTables.inc"),
        ],
    },
    {
        "name": "SystemZ",
        "lower_name": "system_z",
        "short_name": "SystemZ",
        "dir_name": "SystemZ",
        "tbl_outs": [
            ("-gen-asm-writer", "lib/Target/SystemZ/SystemZGenAsmWriter.inc"),
            ("-gen-asm-matcher", "lib/Target/SystemZ/SystemZGenAsmMatcher.inc"),
            ("-gen-emitter", "lib/Target/SystemZ/SystemZGenMCCodeEmitter.inc"),
            ("-gen-register-info", "lib/Target/SystemZ/SystemZGenRegisterInfo.inc"),
            ("-gen-instr-info", "lib/Target/SystemZ/SystemZGenInstrInfo.inc"),
            ("-gen-dag-isel", "lib/Target/SystemZ/SystemZGenDAGISel.inc"),
            ("-gen-callingconv", "lib/Target/SystemZ/SystemZGenCallingConv.inc"),
            ("-gen-subtarget", "lib/Target/SystemZ/SystemZGenSubtargetInfo.inc"),
            ("-gen-disassembler", "lib/Target/SystemZ/SystemZGenDisassemblerTables.inc"),
        ],
    },
    {
        "name": "X86",
        "lower_name": "x86",
        "short_name": "X86",
        "dir_name": "X86",
        "tbl_outs": [
            ("-gen-register-bank", "lib/Target/X86/X86GenRegisterBank.inc"),
            ("-gen-register-info", "lib/Target/X86/X86GenRegisterInfo.inc"),
            ("-gen-disassembler", "lib/Target/X86/X86GenDisassemblerTables.inc"),
            ("-gen-instr-info", "lib/Target/X86/X86GenInstrInfo.inc"),
            ("-gen-asm-writer", "lib/Target/X86/X86GenAsmWriter.inc"),
            ("-gen-asm-writer -asmwriternum=1", "lib/Target/X86/X86GenAsmWriter1.inc"),
            ("-gen-asm-matcher", "lib/Target/X86/X86GenAsmMatcher.inc"),
            ("-gen-dag-isel", "lib/Target/X86/X86GenDAGISel.inc"),
            ("-gen-fast-isel", "lib/Target/X86/X86GenFastISel.inc"),
            ("-gen-global-isel", "lib/Target/X86/X86GenGlobalISel.inc"),
            ("-gen-callingconv", "lib/Target/X86/X86GenCallingConv.inc"),
            ("-gen-subtarget", "lib/Target/X86/X86GenSubtargetInfo.inc"),
            ("-gen-x86-EVEX2VEX-tables", "lib/Target/X86/X86GenEVEX2VEXTables.inc"),
            ("-gen-exegesis", "lib/Target/X86/X86GenExegesis.inc"),
        ],
    },
]

filegroup(
    name = "common_target_td_sources",
    srcs = glob([
        "include/llvm/CodeGen/*.td",
        "include/llvm/Frontend/Directive/*.td",
        "include/llvm/IR/Intrinsics*.td",
        "include/llvm/TableGen/*.td",
        "include/llvm/Target/*.td",
        "include/llvm/Target/GlobalISel/*.td",
    ]),
)

gentbl(
    name = "amdgpu_isel_target_gen",
    tbl_outs = [
        ("-gen-global-isel", "lib/Target/AMDGPU/AMDGPUGenGlobalISel.inc"),
        ("-gen-global-isel-combiner -combiners=AMDGPUPreLegalizerCombinerHelper", "lib/Target/AMDGPU/AMDGPUGenPreLegalizeGICombiner.inc"),
        ("-gen-global-isel-combiner -combiners=AMDGPUPostLegalizerCombinerHelper", "lib/Target/AMDGPU/AMDGPUGenPostLegalizeGICombiner.inc"),
        ("-gen-global-isel-combiner -combiners=AMDGPURegBankCombinerHelper", "lib/Target/AMDGPU/AMDGPUGenRegBankGICombiner.inc"),
    ],
    tblgen = ":llvm-tblgen",
    td_file = "lib/Target/AMDGPU/AMDGPUGISel.td",
    td_srcs = [
        ":common_target_td_sources",
    ] + glob([
        "lib/Target/AMDGPU/*.td",
    ]),
)

gentbl(
    name = "r600_target_gen",
    tbl_outs = [
        ("-gen-asm-writer", "lib/Target/AMDGPU/R600GenAsmWriter.inc"),
        ("-gen-callingconv", "lib/Target/AMDGPU/R600GenCallingConv.inc"),
        ("-gen-dag-isel", "lib/Target/AMDGPU/R600GenDAGISel.inc"),
        ("-gen-dfa-packetizer", "lib/Target/AMDGPU/R600GenDFAPacketizer.inc"),
        ("-gen-instr-info", "lib/Target/AMDGPU/R600GenInstrInfo.inc"),
        ("-gen-emitter", "lib/Target/AMDGPU/R600GenMCCodeEmitter.inc"),
        ("-gen-register-info", "lib/Target/AMDGPU/R600GenRegisterInfo.inc"),
        ("-gen-subtarget", "lib/Target/AMDGPU/R600GenSubtargetInfo.inc"),
    ],
    tblgen = ":llvm-tblgen",
    td_file = "lib/Target/AMDGPU/R600.td",
    td_srcs = [
        ":common_target_td_sources",
    ] + glob([
        "lib/Target/AMDGPU/*.td",
    ]),
)

[gentbl(
    name = target["name"] + "CommonTableGen",
    tbl_outs = target["tbl_outs"],
    tblgen = ":llvm-tblgen",
    td_file = "lib/Target/" + target["dir_name"] + "/" + target["short_name"] + ".td",
    td_srcs = [
        ":common_target_td_sources",
    ] + glob([
        "lib/Target/" + target["dir_name"] + "/*.td",
    ]),
    deps = target.get("tbl_deps", []),
) for target in llvm_target_list]

# This target is used to provide *.def files to x86_code_gen.
# Files with '.def' extension are not allowed in 'srcs' of 'cc_library' rule.
cc_library(
    name = "x86_defs",
    hdrs = glob([
        "lib/Target/X86/*.def",
    ]),
    visibility = ["//visibility:private"],
)

# This filegroup provides the docker build script in LLVM repo
filegroup(
    name = "docker",
    srcs = glob([
        "utils/docker/build_docker_image.sh",
    ]),
    visibility = ["//visibility:public"],
)

py_binary(
    name = "lit",
    srcs = ["utils/lit/lit.py"] + glob(["utils/lit/lit/**/*.py"]),
)

cc_binary(
    name = "count",
    srcs = ["utils/count/count.c"],
)

cc_binary(
    name = "not",
    srcs = ["utils/not/not.cpp"],
    copts = llvm_copts,
    linkopts = llvm_linkopts,
    deps = [
        ":Support",
    ],
)

cc_library(
    name = "AllTargetsCodeGens",
    deps = [
        target["name"] + "CodeGen"
        for target in llvm_target_list
    ],
)

exports_files([
    "include/llvm/Frontend/OpenMP/OMP.td",
])

filegroup(
    name = "omp_td_files",
    srcs = glob([
        "include/llvm/Frontend/OpenMP/*.td",
        "include/llvm/Frontend/Directive/*.td",
    ]),
)

gentbl(
    name = "omp_gen",
    tbl_outs = [("--gen-directive-decl", "include/llvm/Frontend/OpenMP/OMP.h.inc")],
    tblgen = ":llvm-tblgen",
    td_file = "include/llvm/Frontend/OpenMP/OMP.td",
    td_srcs = [
        ":omp_td_files",
    ],
)

gentbl(
    name = "omp_gen_impl",
    tbl_outs = [("--gen-directive-impl", "include/llvm/Frontend/OpenMP/OMP.cpp")],
    tblgen = ":llvm-tblgen",
    td_file = "include/llvm/Frontend/OpenMP/OMP.td",
    td_srcs = [
        ":omp_td_files",
    ],
)

# TODO(b/159809163): autogenerate this after enabling release-mode ML
# InlineAdvisor
cc_library(
    name = "Analysis",
    srcs = glob(
        [
            "lib/Analysis/*.c",
            "lib/Analysis/*.cpp",
            "lib/Analysis/*.inc",
            "include/llvm/Transforms/Utils/Local.h",
            "include/llvm/Transforms/Scalar.h",
            "lib/Analysis/*.h",
        ],
        exclude = [
            "lib/Analysis/DevelopmentModeInlineAdvisor.cpp",
            "lib/Analysis/MLInlineAdvisor.cpp",
            "lib/Analysis/ReleaseModeModelRunner.cpp",
            "lib/Analysis/TFUtils.cpp",
        ],
    ),
    hdrs = glob([
        "include/llvm/Analysis/*.h",
        "include/llvm/Analysis/*.def",
        "include/llvm/Analysis/*.inc",
    ]),
    copts = llvm_copts,
    deps = [
        ":BinaryFormat",
        ":Core",
        ":Object",
        ":ProfileData",
        ":Support",
        ":config",
    ],
)





























































































































########################## Begin autogenerated content #########################
###  This content is autogenerated by generate_bazel_build.py. Do not edit!  ###
################################################################################
cc_library(name='AArch64AsmParser', deps=[':config', ':AArch64Desc', ':AArch64Info', ':AArch64Utils', ':MC', ':MCParser', ':Support'], srcs=glob(['lib/Target/AArch64/AsmParser/*.c', 'lib/Target/AArch64/AsmParser/*.cpp', 'lib/Target/AArch64/AsmParser/*.inc']), hdrs=glob(['include/llvm/Target/AArch64/AsmParser/*.h', 'include/llvm/Target/AArch64/AsmParser/*.def', 'include/llvm/Target/AArch64/AsmParser/*.inc', 'lib/Target/AArch64/AsmParser/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/AArch64'])
cc_library(name='AArch64CodeGen', deps=[':config', ':AArch64Desc', ':AArch64Info', ':AArch64Utils', ':Analysis', ':AsmPrinter', ':CodeGen', ':Core', ':MC', ':Scalar', ':SelectionDAG', ':Support', ':Target', ':TransformUtils', ':GlobalISel', ':CFGuard'], srcs=glob(['lib/Target/AArch64/*.c', 'lib/Target/AArch64/*.cpp', 'lib/Target/AArch64/*.inc', 'lib/Target/AArch64/GISel/*.cpp']), hdrs=glob(['include/llvm/Target/AArch64/*.h', 'include/llvm/Target/AArch64/*.def', 'include/llvm/Target/AArch64/*.inc', 'lib/Target/AArch64/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/AArch64'])
cc_library(name='AArch64Desc', deps=[':config', ':AArch64Info', ':AArch64Utils', ':MC', ':BinaryFormat', ':Support', ':AArch64CommonTableGen', ':attributes_gen', ':intrinsic_enums_gen', ':intrinsics_impl_gen'], srcs=glob(['lib/Target/AArch64/MCTargetDesc/*.c', 'lib/Target/AArch64/MCTargetDesc/*.cpp', 'lib/Target/AArch64/MCTargetDesc/*.inc']), hdrs=glob(['include/llvm/Target/AArch64/MCTargetDesc/*.h', 'include/llvm/Target/AArch64/MCTargetDesc/*.def', 'include/llvm/Target/AArch64/MCTargetDesc/*.inc', 'lib/Target/AArch64/MCTargetDesc/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/AArch64'])
cc_library(name='AArch64Disassembler', deps=[':config', ':AArch64Desc', ':AArch64Info', ':AArch64Utils', ':MC', ':MCDisassembler', ':Support'], srcs=glob(['lib/Target/AArch64/Disassembler/*.c', 'lib/Target/AArch64/Disassembler/*.cpp', 'lib/Target/AArch64/Disassembler/*.inc']), hdrs=glob(['include/llvm/Target/AArch64/Disassembler/*.h', 'include/llvm/Target/AArch64/Disassembler/*.def', 'include/llvm/Target/AArch64/Disassembler/*.inc', 'lib/Target/AArch64/Disassembler/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/AArch64'])
cc_library(name='AArch64Info', deps=[':config', ':Support', ':CodeGen', ':Target'], srcs=glob(['lib/Target/AArch64/TargetInfo/*.c', 'lib/Target/AArch64/TargetInfo/*.cpp', 'lib/Target/AArch64/TargetInfo/*.inc', 'lib/Target/AArch64/MCTargetDesc/*.h']), hdrs=glob(['include/llvm/Target/AArch64/TargetInfo/*.h', 'include/llvm/Target/AArch64/TargetInfo/*.def', 'include/llvm/Target/AArch64/TargetInfo/*.inc', 'lib/Target/AArch64/*.def', 'lib/Target/AArch64/AArch64*.h', 'lib/Target/AArch64/TargetInfo/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/AArch64'])
cc_library(name='AArch64Utils', deps=[':config', ':Support', ':AArch64CommonTableGen', ':MC'], srcs=glob(['lib/Target/AArch64/Utils/*.c', 'lib/Target/AArch64/Utils/*.cpp', 'lib/Target/AArch64/Utils/*.inc', 'lib/Target/AArch64/MCTargetDesc/*.h']), hdrs=glob(['include/llvm/Target/AArch64/Utils/*.h', 'include/llvm/Target/AArch64/Utils/*.def', 'include/llvm/Target/AArch64/Utils/*.inc', 'lib/Target/AArch64/Utils/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/AArch64'])
cc_library(name='AMDGPUAsmParser', deps=[':config', ':MC', ':MCParser', ':AMDGPUDesc', ':AMDGPUInfo', ':AMDGPUUtils', ':Support'], srcs=glob(['lib/Target/AMDGPU/AsmParser/*.c', 'lib/Target/AMDGPU/AsmParser/*.cpp', 'lib/Target/AMDGPU/AsmParser/*.inc']), hdrs=glob(['include/llvm/Target/AMDGPU/AsmParser/*.h', 'include/llvm/Target/AMDGPU/AsmParser/*.def', 'include/llvm/Target/AMDGPU/AsmParser/*.inc', 'lib/Target/AMDGPU/AsmParser/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/AMDGPU'])
cc_library(name='AMDGPUCodeGen', deps=[':config', ':Analysis', ':AsmPrinter', ':CodeGen', ':Core', ':IPO', ':MC', ':AMDGPUDesc', ':AMDGPUInfo', ':AMDGPUUtils', ':Scalar', ':SelectionDAG', ':Support', ':Target', ':TransformUtils', ':Vectorize', ':GlobalISel', ':BinaryFormat', ':MIRParser'], srcs=glob(['lib/Target/AMDGPU/*.c', 'lib/Target/AMDGPU/*.cpp', 'lib/Target/AMDGPU/*.inc']), hdrs=glob(['include/llvm/Target/AMDGPU/*.h', 'include/llvm/Target/AMDGPU/*.def', 'include/llvm/Target/AMDGPU/*.inc', 'lib/Target/AMDGPU/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/AMDGPU'])
cc_library(name='AMDGPUDesc', deps=[':config', ':Core', ':MC', ':AMDGPUInfo', ':AMDGPUUtils', ':Support', ':BinaryFormat'], srcs=glob(['lib/Target/AMDGPU/MCTargetDesc/*.c', 'lib/Target/AMDGPU/MCTargetDesc/*.cpp', 'lib/Target/AMDGPU/MCTargetDesc/*.inc']), hdrs=glob(['include/llvm/Target/AMDGPU/MCTargetDesc/*.h', 'include/llvm/Target/AMDGPU/MCTargetDesc/*.def', 'include/llvm/Target/AMDGPU/MCTargetDesc/*.inc', 'lib/Target/AMDGPU/MCTargetDesc/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/AMDGPU'])
cc_library(name='AMDGPUDisassembler', deps=[':config', ':AMDGPUDesc', ':AMDGPUInfo', ':AMDGPUUtils', ':MC', ':MCDisassembler', ':Support'], srcs=glob(['lib/Target/AMDGPU/Disassembler/*.c', 'lib/Target/AMDGPU/Disassembler/*.cpp', 'lib/Target/AMDGPU/Disassembler/*.inc']), hdrs=glob(['include/llvm/Target/AMDGPU/Disassembler/*.h', 'include/llvm/Target/AMDGPU/Disassembler/*.def', 'include/llvm/Target/AMDGPU/Disassembler/*.inc', 'lib/Target/AMDGPU/Disassembler/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/AMDGPU'])
cc_library(name='AMDGPUInfo', deps=[':config', ':Support', ':AMDGPUCommonTableGen', ':r600_target_gen', ':Core'], srcs=glob(['lib/Target/AMDGPU/TargetInfo/*.c', 'lib/Target/AMDGPU/TargetInfo/*.cpp', 'lib/Target/AMDGPU/TargetInfo/*.inc']), hdrs=glob(['include/llvm/Target/AMDGPU/TargetInfo/*.h', 'include/llvm/Target/AMDGPU/TargetInfo/*.def', 'include/llvm/Target/AMDGPU/TargetInfo/*.inc', 'lib/Target/AMDGPU/TargetInfo/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/AMDGPU'])
cc_library(name='AMDGPUUtils', deps=[':config', ':Core', ':MC', ':BinaryFormat', ':Support', ':AMDGPUCommonTableGen', ':r600_target_gen'], srcs=glob(['lib/Target/AMDGPU/Utils/*.c', 'lib/Target/AMDGPU/Utils/*.cpp', 'lib/Target/AMDGPU/Utils/*.inc']), hdrs=glob(['include/llvm/Target/AMDGPU/Utils/*.h', 'include/llvm/Target/AMDGPU/Utils/*.def', 'include/llvm/Target/AMDGPU/Utils/*.inc', 'lib/Target/AMDGPU/Utils/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/AMDGPU'])
cc_library(name='ARCCodeGen', deps=[':config', ':Analysis', ':AsmPrinter', ':CodeGen', ':Core', ':MC', ':SelectionDAG', ':Support', ':Target', ':TransformUtils', ':ARCDesc', ':ARCInfo'], srcs=glob(['lib/Target/ARC/*.c', 'lib/Target/ARC/*.cpp', 'lib/Target/ARC/*.inc']), hdrs=glob(['include/llvm/Target/ARC/*.h', 'include/llvm/Target/ARC/*.def', 'include/llvm/Target/ARC/*.inc', 'lib/Target/ARC/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/ARC'])
cc_library(name='ARCDesc', deps=[':config', ':MC', ':Support', ':ARCInfo'], srcs=glob(['lib/Target/ARC/MCTargetDesc/*.c', 'lib/Target/ARC/MCTargetDesc/*.cpp', 'lib/Target/ARC/MCTargetDesc/*.inc']), hdrs=glob(['include/llvm/Target/ARC/MCTargetDesc/*.h', 'include/llvm/Target/ARC/MCTargetDesc/*.def', 'include/llvm/Target/ARC/MCTargetDesc/*.inc', 'lib/Target/ARC/MCTargetDesc/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/ARC'])
cc_library(name='ARCDisassembler', deps=[':config', ':MCDisassembler', ':Support', ':ARCInfo'], srcs=glob(['lib/Target/ARC/Disassembler/*.c', 'lib/Target/ARC/Disassembler/*.cpp', 'lib/Target/ARC/Disassembler/*.inc']), hdrs=glob(['include/llvm/Target/ARC/Disassembler/*.h', 'include/llvm/Target/ARC/Disassembler/*.def', 'include/llvm/Target/ARC/Disassembler/*.inc', 'lib/Target/ARC/Disassembler/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/ARC'])
cc_library(name='ARCInfo', deps=[':config', ':Support'], srcs=glob(['lib/Target/ARC/TargetInfo/*.c', 'lib/Target/ARC/TargetInfo/*.cpp', 'lib/Target/ARC/TargetInfo/*.inc']), hdrs=glob(['include/llvm/Target/ARC/TargetInfo/*.h', 'include/llvm/Target/ARC/TargetInfo/*.def', 'include/llvm/Target/ARC/TargetInfo/*.inc', 'lib/Target/ARC/TargetInfo/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/ARC'])
cc_library(name='ARMAsmParser', deps=[':config', ':ARMDesc', ':ARMInfo', ':MC', ':MCParser', ':Support', ':ARMUtils'], srcs=glob(['lib/Target/ARM/AsmParser/*.c', 'lib/Target/ARM/AsmParser/*.cpp', 'lib/Target/ARM/AsmParser/*.inc']), hdrs=glob(['include/llvm/Target/ARM/AsmParser/*.h', 'include/llvm/Target/ARM/AsmParser/*.def', 'include/llvm/Target/ARM/AsmParser/*.inc', 'lib/Target/ARM/AsmParser/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/ARM'])
cc_library(name='ARMCodeGen', deps=[':config', ':ARMDesc', ':ARMInfo', ':Analysis', ':AsmPrinter', ':CodeGen', ':Core', ':MC', ':Scalar', ':SelectionDAG', ':Support', ':Target', ':GlobalISel', ':ARMUtils', ':TransformUtils', ':CFGuard'], srcs=glob(['lib/Target/ARM/*.c', 'lib/Target/ARM/*.cpp', 'lib/Target/ARM/*.inc']), hdrs=glob(['include/llvm/Target/ARM/*.h', 'include/llvm/Target/ARM/*.def', 'include/llvm/Target/ARM/*.inc', 'lib/Target/ARM/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/ARM'])
cc_library(name='ARMDesc', deps=[':config', ':ARMInfo', ':ARMUtils', ':MC', ':MCDisassembler', ':Support', ':BinaryFormat', ':ARMCommonTableGen', ':attributes_gen', ':intrinsic_enums_gen', ':intrinsics_impl_gen'], srcs=glob(['lib/Target/ARM/MCTargetDesc/*.c', 'lib/Target/ARM/MCTargetDesc/*.cpp', 'lib/Target/ARM/MCTargetDesc/*.inc', 'lib/Target/ARM/*.h', 'include/llvm/CodeGen/GlobalISel/*.h']), hdrs=glob(['include/llvm/Target/ARM/MCTargetDesc/*.h', 'include/llvm/Target/ARM/MCTargetDesc/*.def', 'include/llvm/Target/ARM/MCTargetDesc/*.inc', 'lib/Target/ARM/MCTargetDesc/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/ARM'])
cc_library(name='ARMDisassembler', deps=[':config', ':ARMDesc', ':ARMInfo', ':MCDisassembler', ':Support', ':ARMUtils'], srcs=glob(['lib/Target/ARM/Disassembler/*.c', 'lib/Target/ARM/Disassembler/*.cpp', 'lib/Target/ARM/Disassembler/*.inc']), hdrs=glob(['include/llvm/Target/ARM/Disassembler/*.h', 'include/llvm/Target/ARM/Disassembler/*.def', 'include/llvm/Target/ARM/Disassembler/*.inc', 'lib/Target/ARM/Disassembler/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/ARM'])
cc_library(name='ARMInfo', deps=[':config', ':Support', ':ARMCommonTableGen', ':Target'], srcs=glob(['lib/Target/ARM/TargetInfo/*.c', 'lib/Target/ARM/TargetInfo/*.cpp', 'lib/Target/ARM/TargetInfo/*.inc', 'lib/Target/ARM/MCTargetDesc/*.h']), hdrs=glob(['include/llvm/Target/ARM/TargetInfo/*.h', 'include/llvm/Target/ARM/TargetInfo/*.def', 'include/llvm/Target/ARM/TargetInfo/*.inc', 'lib/Target/ARM/TargetInfo/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/ARM'])
cc_library(name='ARMUtils', deps=[':config', ':Support', ':ARMCommonTableGen', ':MC'], srcs=glob(['lib/Target/ARM/Utils/*.c', 'lib/Target/ARM/Utils/*.cpp', 'lib/Target/ARM/Utils/*.inc', 'lib/Target/ARM/MCTargetDesc/*.h']), hdrs=glob(['include/llvm/Target/ARM/Utils/*.h', 'include/llvm/Target/ARM/Utils/*.def', 'include/llvm/Target/ARM/Utils/*.inc', 'lib/Target/ARM/Utils/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/ARM'])
cc_library(name='AVRAsmParser', deps=[':config', ':MC', ':MCParser', ':AVRDesc', ':AVRInfo', ':Support'], srcs=glob(['lib/Target/AVR/AsmParser/*.c', 'lib/Target/AVR/AsmParser/*.cpp', 'lib/Target/AVR/AsmParser/*.inc']), hdrs=glob(['include/llvm/Target/AVR/AsmParser/*.h', 'include/llvm/Target/AVR/AsmParser/*.def', 'include/llvm/Target/AVR/AsmParser/*.inc', 'lib/Target/AVR/AsmParser/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/AVR'])
cc_library(name='AVRCodeGen', deps=[':config', ':AsmPrinter', ':CodeGen', ':Core', ':MC', ':AVRDesc', ':AVRInfo', ':SelectionDAG', ':Support', ':Target'], srcs=glob(['lib/Target/AVR/*.c', 'lib/Target/AVR/*.cpp', 'lib/Target/AVR/*.inc']), hdrs=glob(['include/llvm/Target/AVR/*.h', 'include/llvm/Target/AVR/*.def', 'include/llvm/Target/AVR/*.inc', 'lib/Target/AVR/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/AVR'])
cc_library(name='AVRDesc', deps=[':config', ':MC', ':AVRInfo', ':Support'], srcs=glob(['lib/Target/AVR/MCTargetDesc/*.c', 'lib/Target/AVR/MCTargetDesc/*.cpp', 'lib/Target/AVR/MCTargetDesc/*.inc']), hdrs=glob(['include/llvm/Target/AVR/MCTargetDesc/*.h', 'include/llvm/Target/AVR/MCTargetDesc/*.def', 'include/llvm/Target/AVR/MCTargetDesc/*.inc', 'lib/Target/AVR/MCTargetDesc/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/AVR'])
cc_library(name='AVRDisassembler', deps=[':config', ':MCDisassembler', ':AVRInfo', ':Support'], srcs=glob(['lib/Target/AVR/Disassembler/*.c', 'lib/Target/AVR/Disassembler/*.cpp', 'lib/Target/AVR/Disassembler/*.inc']), hdrs=glob(['include/llvm/Target/AVR/Disassembler/*.h', 'include/llvm/Target/AVR/Disassembler/*.def', 'include/llvm/Target/AVR/Disassembler/*.inc', 'lib/Target/AVR/Disassembler/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/AVR'])
cc_library(name='AVRInfo', deps=[':config', ':Support'], srcs=glob(['lib/Target/AVR/TargetInfo/*.c', 'lib/Target/AVR/TargetInfo/*.cpp', 'lib/Target/AVR/TargetInfo/*.inc']), hdrs=glob(['include/llvm/Target/AVR/TargetInfo/*.h', 'include/llvm/Target/AVR/TargetInfo/*.def', 'include/llvm/Target/AVR/TargetInfo/*.inc', 'lib/Target/AVR/TargetInfo/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/AVR'])
cc_library(name='AggressiveInstCombine', deps=[':config', ':Analysis', ':Core', ':Support', ':TransformUtils'], srcs=glob(['lib/Transforms/AggressiveInstCombine/*.c', 'lib/Transforms/AggressiveInstCombine/*.cpp', 'lib/Transforms/AggressiveInstCombine/*.inc', 'lib/Transforms/AggressiveInstCombine/*.h']), hdrs=glob(['include/llvm/Transforms/AggressiveInstCombine/*.h', 'include/llvm/Transforms/AggressiveInstCombine/*.def', 'include/llvm/Transforms/AggressiveInstCombine/*.inc']), copts=llvm_copts)
cc_library(name='AsmParser', deps=[':config', ':BinaryFormat', ':Core', ':Support'], srcs=glob(['lib/AsmParser/*.c', 'lib/AsmParser/*.cpp', 'lib/AsmParser/*.inc', 'lib/AsmParser/*.h']), hdrs=glob(['include/llvm/AsmParser/*.h', 'include/llvm/AsmParser/*.def', 'include/llvm/AsmParser/*.inc']), copts=llvm_copts)
cc_library(name='AsmPrinter', deps=[':config', ':Analysis', ':BinaryFormat', ':CodeGen', ':Core', ':DebugInfoCodeView', ':DebugInfoDWARF', ':DebugInfoMSF', ':MC', ':MCParser', ':Remarks', ':Support', ':Target'], srcs=glob(['lib/CodeGen/AsmPrinter/*.c', 'lib/CodeGen/AsmPrinter/*.cpp', 'lib/CodeGen/AsmPrinter/*.inc', 'lib/CodeGen/AsmPrinter/*.h']), hdrs=glob(['include/llvm/CodeGen/AsmPrinter/*.h', 'include/llvm/CodeGen/AsmPrinter/*.def', 'include/llvm/CodeGen/AsmPrinter/*.inc', 'lib/CodeGen/AsmPrinter/*.def']), copts=llvm_copts)
cc_library(name='BPFAsmParser', deps=[':config', ':MC', ':MCParser', ':BPFDesc', ':BPFInfo', ':Support'], srcs=glob(['lib/Target/BPF/AsmParser/*.c', 'lib/Target/BPF/AsmParser/*.cpp', 'lib/Target/BPF/AsmParser/*.inc']), hdrs=glob(['include/llvm/Target/BPF/AsmParser/*.h', 'include/llvm/Target/BPF/AsmParser/*.def', 'include/llvm/Target/BPF/AsmParser/*.inc', 'lib/Target/BPF/AsmParser/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/BPF'])
cc_library(name='BPFCodeGen', deps=[':config', ':AsmPrinter', ':CodeGen', ':Core', ':MC', ':BPFDesc', ':BPFInfo', ':IPO', ':Scalar', ':SelectionDAG', ':Support', ':Target'], srcs=glob(['lib/Target/BPF/*.c', 'lib/Target/BPF/*.cpp', 'lib/Target/BPF/*.inc']), hdrs=glob(['include/llvm/Target/BPF/*.h', 'include/llvm/Target/BPF/*.def', 'include/llvm/Target/BPF/*.inc', 'lib/Target/BPF/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/BPF'])
cc_library(name='BPFDesc', deps=[':config', ':MC', ':BPFInfo', ':Support'], srcs=glob(['lib/Target/BPF/MCTargetDesc/*.c', 'lib/Target/BPF/MCTargetDesc/*.cpp', 'lib/Target/BPF/MCTargetDesc/*.inc']), hdrs=glob(['include/llvm/Target/BPF/MCTargetDesc/*.h', 'include/llvm/Target/BPF/MCTargetDesc/*.def', 'include/llvm/Target/BPF/MCTargetDesc/*.inc', 'lib/Target/BPF/MCTargetDesc/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/BPF'])
cc_library(name='BPFDisassembler', deps=[':config', ':MCDisassembler', ':BPFInfo', ':Support'], srcs=glob(['lib/Target/BPF/Disassembler/*.c', 'lib/Target/BPF/Disassembler/*.cpp', 'lib/Target/BPF/Disassembler/*.inc']), hdrs=glob(['include/llvm/Target/BPF/Disassembler/*.h', 'include/llvm/Target/BPF/Disassembler/*.def', 'include/llvm/Target/BPF/Disassembler/*.inc', 'lib/Target/BPF/Disassembler/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/BPF'])
cc_library(name='BPFInfo', deps=[':config', ':Support'], srcs=glob(['lib/Target/BPF/TargetInfo/*.c', 'lib/Target/BPF/TargetInfo/*.cpp', 'lib/Target/BPF/TargetInfo/*.inc']), hdrs=glob(['include/llvm/Target/BPF/TargetInfo/*.h', 'include/llvm/Target/BPF/TargetInfo/*.def', 'include/llvm/Target/BPF/TargetInfo/*.inc', 'lib/Target/BPF/TargetInfo/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/BPF'])
cc_library(name='BinaryFormat', deps=[':config', ':Support'], srcs=glob(['lib/BinaryFormat/*.c', 'lib/BinaryFormat/*.cpp', 'lib/BinaryFormat/*.inc', 'lib/BinaryFormat/*.h']), hdrs=glob(['include/llvm/BinaryFormat/*.h', 'include/llvm/BinaryFormat/*.def', 'include/llvm/BinaryFormat/*.inc', 'include/llvm/BinaryFormat/ELFRelocs/*.def', 'include/llvm/BinaryFormat/WasmRelocs/*.def']), copts=llvm_copts)
cc_library(name='BitReader', deps=[':config', ':BitstreamReader', ':Core', ':Support'], srcs=glob(['lib/Bitcode/Reader/*.c', 'lib/Bitcode/Reader/*.cpp', 'lib/Bitcode/Reader/*.inc', 'lib/Bitcode/Reader/*.h']), hdrs=glob(['include/llvm/Bitcode/Reader/*.h', 'include/llvm/Bitcode/Reader/*.def', 'include/llvm/Bitcode/Reader/*.inc', 'include/llvm/Bitcode/BitstreamReader.h']), copts=llvm_copts)
cc_library(name='BitWriter', deps=[':config', ':Analysis', ':Core', ':MC', ':Object', ':Support'], srcs=glob(['lib/Bitcode/Writer/*.c', 'lib/Bitcode/Writer/*.cpp', 'lib/Bitcode/Writer/*.inc', 'lib/Bitcode/Writer/*.h']), hdrs=glob(['include/llvm/Bitcode/Writer/*.h', 'include/llvm/Bitcode/Writer/*.def', 'include/llvm/Bitcode/Writer/*.inc', 'include/llvm/Bitcode/BitcodeWriter.h', 'include/llvm/Bitcode/BitcodeWriterPass.h', 'include/llvm/Bitcode/BitstreamWriter.h']), copts=llvm_copts)
cc_library(name='BitstreamReader', deps=[':config', ':Support'], srcs=glob(['lib/Bitstream/Reader/*.c', 'lib/Bitstream/Reader/*.cpp', 'lib/Bitstream/Reader/*.inc', 'lib/Bitstream/Reader/*.h']), hdrs=glob(['include/llvm/Bitstream/Reader/*.h', 'include/llvm/Bitstream/Reader/*.def', 'include/llvm/Bitstream/Reader/*.inc']), copts=llvm_copts)
cc_library(name='CFGuard', deps=[':config', ':Core', ':Support'], srcs=glob(['lib/Transforms/CFGuard/*.c', 'lib/Transforms/CFGuard/*.cpp', 'lib/Transforms/CFGuard/*.inc', 'lib/Transforms/CFGuard/*.h']), hdrs=glob(['include/llvm/Transforms/CFGuard/*.h', 'include/llvm/Transforms/CFGuard/*.def', 'include/llvm/Transforms/CFGuard/*.inc']), copts=llvm_copts)
cc_library(name='CodeGen', deps=[':config', ':Analysis', ':BitReader', ':BitWriter', ':Core', ':MC', ':ProfileData', ':Scalar', ':Support', ':Target', ':TransformUtils', ':Instrumentation'], srcs=glob(['lib/CodeGen/*.c', 'lib/CodeGen/*.cpp', 'lib/CodeGen/*.inc', 'lib/CodeGen/*.h']), hdrs=glob(['include/llvm/CodeGen/*.h', 'include/llvm/CodeGen/*.def', 'include/llvm/CodeGen/*.inc', 'include/llvm/CodeGen/**/*.h']), copts=llvm_copts)
cc_library(name='Core', deps=[':config', ':BinaryFormat', ':Remarks', ':Support', ':attributes_gen', ':intrinsic_enums_gen', ':intrinsics_impl_gen', ':aarch64_enums_gen', ':amdgcn_enums_gen', ':arm_enums_gen', ':bpf_enums_gen', ':hexagon_enums_gen', ':mips_enums_gen', ':nvvm_enums_gen', ':ppc_enums_gen', ':r600_enums_gen', ':riscv_enums_gen', ':s390_enums_gen', ':wasm_enums_gen', ':x86_enums_gen', ':xcore_enums_gen'], srcs=glob(['lib/IR/*.c', 'lib/IR/*.cpp', 'lib/IR/*.inc', 'include/llvm/Analysis/*.h', 'include/llvm/Bitcode/BitcodeReader.h', 'include/llvm/Bitcode/BitCodes.h', 'include/llvm/Bitcode/LLVMBitCodes.h', 'include/llvm/CodeGen/MachineValueType.h', 'include/llvm/CodeGen/ValueTypes.h', 'lib/IR/*.h']), hdrs=glob(['include/llvm/IR/*.h', 'include/llvm/IR/*.def', 'include/llvm/IR/*.inc', 'include/llvm/*.h', 'include/llvm/Analysis/*.def']), copts=llvm_copts)
cc_library(name='Coroutines', deps=[':config', ':Analysis', ':Core', ':IPO', ':Scalar', ':Support', ':TransformUtils'], srcs=glob(['lib/Transforms/Coroutines/*.c', 'lib/Transforms/Coroutines/*.cpp', 'lib/Transforms/Coroutines/*.inc', 'lib/Transforms/Coroutines/*.h']), hdrs=glob(['include/llvm/Transforms/Coroutines/*.h', 'include/llvm/Transforms/Coroutines/*.def', 'include/llvm/Transforms/Coroutines/*.inc']), copts=llvm_copts)
cc_library(name='Coverage', deps=[':config', ':Core', ':Object', ':ProfileData', ':Support'], srcs=glob(['lib/ProfileData/Coverage/*.c', 'lib/ProfileData/Coverage/*.cpp', 'lib/ProfileData/Coverage/*.inc', 'lib/ProfileData/Coverage/*.h']), hdrs=glob(['include/llvm/ProfileData/Coverage/*.h', 'include/llvm/ProfileData/Coverage/*.def', 'include/llvm/ProfileData/Coverage/*.inc']), copts=llvm_copts)
cc_library(name='DWARFLinker', deps=[':config', ':DebugInfoDWARF', ':AsmPrinter', ':CodeGen', ':MC', ':Object', ':Support'], srcs=glob(['lib/DWARFLinker/*.c', 'lib/DWARFLinker/*.cpp', 'lib/DWARFLinker/*.inc', 'lib/DWARFLinker/*.h']), hdrs=glob(['include/llvm/DWARFLinker/*.h', 'include/llvm/DWARFLinker/*.def', 'include/llvm/DWARFLinker/*.inc']), copts=llvm_copts)
cc_library(name='DebugInfoCodeView', deps=[':config', ':Support', ':DebugInfoMSF', ':BinaryFormat'], srcs=glob(['lib/DebugInfo/CodeView/*.c', 'lib/DebugInfo/CodeView/*.cpp', 'lib/DebugInfo/CodeView/*.inc', 'lib/DebugInfo/CodeView/*.h']), hdrs=glob(['include/llvm/DebugInfo/CodeView/*.h', 'include/llvm/DebugInfo/CodeView/*.def', 'include/llvm/DebugInfo/CodeView/*.inc']), copts=llvm_copts)
cc_library(name='DebugInfoDWARF', deps=[':config', ':BinaryFormat', ':Object', ':MC', ':Support'], srcs=glob(['lib/DebugInfo/DWARF/*.c', 'lib/DebugInfo/DWARF/*.cpp', 'lib/DebugInfo/DWARF/*.inc', 'lib/DebugInfo/DWARF/*.h']), hdrs=glob(['include/llvm/DebugInfo/DWARF/*.h', 'include/llvm/DebugInfo/DWARF/*.def', 'include/llvm/DebugInfo/DWARF/*.inc']), copts=llvm_copts)
cc_library(name='DebugInfoGSYM', deps=[':config', ':MC', ':Object', ':Support', ':DebugInfoDWARF'], srcs=glob(['lib/DebugInfo/GSYM/*.c', 'lib/DebugInfo/GSYM/*.cpp', 'lib/DebugInfo/GSYM/*.inc', 'lib/DebugInfo/GSYM/*.h']), hdrs=glob(['include/llvm/DebugInfo/GSYM/*.h', 'include/llvm/DebugInfo/GSYM/*.def', 'include/llvm/DebugInfo/GSYM/*.inc']), copts=llvm_copts)
cc_library(name='DebugInfoMSF', deps=[':config', ':Support'], srcs=glob(['lib/DebugInfo/MSF/*.c', 'lib/DebugInfo/MSF/*.cpp', 'lib/DebugInfo/MSF/*.inc', 'lib/DebugInfo/MSF/*.h']), hdrs=glob(['include/llvm/DebugInfo/MSF/*.h', 'include/llvm/DebugInfo/MSF/*.def', 'include/llvm/DebugInfo/MSF/*.inc']), copts=llvm_copts)
cc_library(name='DebugInfoPDB', deps=[':config', ':BinaryFormat', ':Object', ':Support', ':DebugInfoCodeView', ':DebugInfoMSF'], srcs=glob(['lib/DebugInfo/PDB/*.c', 'lib/DebugInfo/PDB/*.cpp', 'lib/DebugInfo/PDB/*.inc', 'lib/DebugInfo/PDB/*.h']), hdrs=glob(['include/llvm/DebugInfo/PDB/*.h', 'include/llvm/DebugInfo/PDB/*.def', 'include/llvm/DebugInfo/PDB/*.inc']), copts=llvm_copts)
cc_library(name='Demangle', deps=[':config'], srcs=glob(['lib/Demangle/*.c', 'lib/Demangle/*.cpp', 'lib/Demangle/*.inc', 'lib/Demangle/*.h']), hdrs=glob(['include/llvm/Demangle/*.h', 'include/llvm/Demangle/*.def', 'include/llvm/Demangle/*.inc']), copts=llvm_copts)
cc_library(name='DlltoolDriver', deps=[':config', ':Object', ':Option', ':Support'], srcs=glob(['lib/ToolDrivers/llvm-dlltool/*.c', 'lib/ToolDrivers/llvm-dlltool/*.cpp', 'lib/ToolDrivers/llvm-dlltool/*.inc', 'lib/ToolDrivers/llvm-dlltool/*.h']), hdrs=glob(['include/llvm/ToolDrivers/llvm-dlltool/*.h', 'include/llvm/ToolDrivers/llvm-dlltool/*.def', 'include/llvm/ToolDrivers/llvm-dlltool/*.inc']), copts=llvm_copts)
cc_library(name='ExecutionEngine', deps=[':config', ':Core', ':MC', ':Object', ':RuntimeDyld', ':Support', ':Target'], srcs=glob(['lib/ExecutionEngine/*.c', 'lib/ExecutionEngine/*.cpp', 'lib/ExecutionEngine/*.inc', 'lib/ExecutionEngine/*.h']), hdrs=glob(['include/llvm/ExecutionEngine/*.h', 'include/llvm/ExecutionEngine/*.def', 'include/llvm/ExecutionEngine/*.inc']), copts=llvm_copts)
cc_library(name='Extensions', deps=[':config'], srcs=glob(['lib/Extensions/*.c', 'lib/Extensions/*.cpp', 'lib/Extensions/*.inc', 'lib/Extensions/*.h']), hdrs=glob(['include/llvm/Extensions/*.h', 'include/llvm/Extensions/*.def', 'include/llvm/Extensions/*.inc']), copts=llvm_copts)
cc_library(name='FrontendOpenMP', deps=[':config', ':Core', ':Support', ':TransformUtils', ':omp_gen', ':omp_gen_impl'], srcs=glob(['lib/Frontend/OpenMP/*.c', 'lib/Frontend/OpenMP/*.cpp', 'lib/Frontend/OpenMP/*.inc', 'lib/Frontend/OpenMP/*.h']) + ['include/llvm/Frontend/OpenMP/OMP.cpp'], hdrs=glob(['include/llvm/Frontend/OpenMP/*.h', 'include/llvm/Frontend/OpenMP/*.def', 'include/llvm/Frontend/OpenMP/*.inc']), copts=llvm_copts)
cc_library(name='FuzzMutate', deps=[':config', ':Analysis', ':BitReader', ':BitWriter', ':Core', ':Scalar', ':Support', ':Target'], srcs=glob(['lib/FuzzMutate/*.c', 'lib/FuzzMutate/*.cpp', 'lib/FuzzMutate/*.inc', 'lib/FuzzMutate/*.h']), hdrs=glob(['include/llvm/FuzzMutate/*.h', 'include/llvm/FuzzMutate/*.def', 'include/llvm/FuzzMutate/*.inc']), copts=llvm_copts)
cc_library(name='GlobalISel', deps=[':config', ':Analysis', ':CodeGen', ':Core', ':MC', ':SelectionDAG', ':Support', ':Target', ':TransformUtils'], srcs=glob(['lib/CodeGen/GlobalISel/*.c', 'lib/CodeGen/GlobalISel/*.cpp', 'lib/CodeGen/GlobalISel/*.inc', 'lib/CodeGen/GlobalISel/*.h']), hdrs=glob(['include/llvm/CodeGen/GlobalISel/*.h', 'include/llvm/CodeGen/GlobalISel/*.def', 'include/llvm/CodeGen/GlobalISel/*.inc']), copts=llvm_copts)
cc_library(name='HexagonAsmParser', deps=[':config', ':MC', ':MCParser', ':Support', ':HexagonDesc', ':HexagonInfo'], srcs=glob(['lib/Target/Hexagon/AsmParser/*.c', 'lib/Target/Hexagon/AsmParser/*.cpp', 'lib/Target/Hexagon/AsmParser/*.inc']), hdrs=glob(['include/llvm/Target/Hexagon/AsmParser/*.h', 'include/llvm/Target/Hexagon/AsmParser/*.def', 'include/llvm/Target/Hexagon/AsmParser/*.inc', 'lib/Target/Hexagon/AsmParser/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/Hexagon'])
cc_library(name='HexagonCodeGen', deps=[':config', ':Analysis', ':AsmPrinter', ':CodeGen', ':Core', ':HexagonAsmParser', ':HexagonDesc', ':HexagonInfo', ':IPO', ':MC', ':Scalar', ':SelectionDAG', ':Support', ':Target', ':TransformUtils'], srcs=glob(['lib/Target/Hexagon/*.c', 'lib/Target/Hexagon/*.cpp', 'lib/Target/Hexagon/*.inc']), hdrs=glob(['include/llvm/Target/Hexagon/*.h', 'include/llvm/Target/Hexagon/*.def', 'include/llvm/Target/Hexagon/*.inc', 'lib/Target/Hexagon/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/Hexagon'])
cc_library(name='HexagonDesc', deps=[':config', ':HexagonInfo', ':MC', ':Support'], srcs=glob(['lib/Target/Hexagon/MCTargetDesc/*.c', 'lib/Target/Hexagon/MCTargetDesc/*.cpp', 'lib/Target/Hexagon/MCTargetDesc/*.inc']), hdrs=glob(['include/llvm/Target/Hexagon/MCTargetDesc/*.h', 'include/llvm/Target/Hexagon/MCTargetDesc/*.def', 'include/llvm/Target/Hexagon/MCTargetDesc/*.inc', 'lib/Target/Hexagon/MCTargetDesc/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/Hexagon'])
cc_library(name='HexagonDisassembler', deps=[':config', ':HexagonDesc', ':HexagonInfo', ':MC', ':MCDisassembler', ':Support'], srcs=glob(['lib/Target/Hexagon/Disassembler/*.c', 'lib/Target/Hexagon/Disassembler/*.cpp', 'lib/Target/Hexagon/Disassembler/*.inc']), hdrs=glob(['include/llvm/Target/Hexagon/Disassembler/*.h', 'include/llvm/Target/Hexagon/Disassembler/*.def', 'include/llvm/Target/Hexagon/Disassembler/*.inc', 'lib/Target/Hexagon/Disassembler/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/Hexagon'])
cc_library(name='HexagonInfo', deps=[':config', ':Support'], srcs=glob(['lib/Target/Hexagon/TargetInfo/*.c', 'lib/Target/Hexagon/TargetInfo/*.cpp', 'lib/Target/Hexagon/TargetInfo/*.inc']), hdrs=glob(['include/llvm/Target/Hexagon/TargetInfo/*.h', 'include/llvm/Target/Hexagon/TargetInfo/*.def', 'include/llvm/Target/Hexagon/TargetInfo/*.inc', 'lib/Target/Hexagon/TargetInfo/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/Hexagon'])
cc_library(name='IPO', deps=[':config', ':AggressiveInstCombine', ':Analysis', ':BitReader', ':BitWriter', ':Core', ':FrontendOpenMP', ':InstCombine', ':IRReader', ':Linker', ':Object', ':ProfileData', ':Scalar', ':Support', ':TransformUtils', ':Vectorize', ':Instrumentation'], srcs=glob(['lib/Transforms/IPO/*.c', 'lib/Transforms/IPO/*.cpp', 'lib/Transforms/IPO/*.inc', 'include/llvm/Transforms/SampleProfile.h', 'include/llvm-c/Transforms/IPO.h', 'include/llvm-c/Transforms/PassManagerBuilder.h', 'lib/Transforms/IPO/*.h']), hdrs=glob(['include/llvm/Transforms/IPO/*.h', 'include/llvm/Transforms/IPO/*.def', 'include/llvm/Transforms/IPO/*.inc']), copts=llvm_copts)
cc_library(name='IRReader', deps=[':config', ':AsmParser', ':BitReader', ':Core', ':Support'], srcs=glob(['lib/IRReader/*.c', 'lib/IRReader/*.cpp', 'lib/IRReader/*.inc', 'lib/IRReader/*.h']), hdrs=glob(['include/llvm/IRReader/*.h', 'include/llvm/IRReader/*.def', 'include/llvm/IRReader/*.inc']), copts=llvm_copts)
cc_library(name='InstCombine', deps=[':config', ':Analysis', ':Core', ':Support', ':TransformUtils', ':InstCombineTableGen'], srcs=glob(['lib/Transforms/InstCombine/*.c', 'lib/Transforms/InstCombine/*.cpp', 'lib/Transforms/InstCombine/*.inc', 'lib/Transforms/InstCombine/*.h']), hdrs=glob(['include/llvm/Transforms/InstCombine/*.h', 'include/llvm/Transforms/InstCombine/*.def', 'include/llvm/Transforms/InstCombine/*.inc']), copts=llvm_copts)
cc_library(name='Instrumentation', deps=[':config', ':Analysis', ':Core', ':MC', ':Support', ':TransformUtils', ':ProfileData'], srcs=glob(['lib/Transforms/Instrumentation/*.c', 'lib/Transforms/Instrumentation/*.cpp', 'lib/Transforms/Instrumentation/*.inc', 'lib/Transforms/Instrumentation/*.h']), hdrs=glob(['include/llvm/Transforms/Instrumentation/*.h', 'include/llvm/Transforms/Instrumentation/*.def', 'include/llvm/Transforms/Instrumentation/*.inc', 'include/llvm/Transforms/GCOVProfiler.h', 'include/llvm/Transforms/Instrumentation.h', 'include/llvm/Transforms/InstrProfiling.h', 'include/llvm/Transforms/PGOInstrumentation.h']), copts=llvm_copts)
cc_library(name='InterfaceStub', deps=[':config', ':Object', ':Support'], srcs=glob(['lib/InterfaceStub/*.c', 'lib/InterfaceStub/*.cpp', 'lib/InterfaceStub/*.inc', 'lib/InterfaceStub/*.h']), hdrs=glob(['include/llvm/InterfaceStub/*.h', 'include/llvm/InterfaceStub/*.def', 'include/llvm/InterfaceStub/*.inc']), copts=llvm_copts)
cc_library(name='Interpreter', deps=[':config', ':CodeGen', ':Core', ':ExecutionEngine', ':Support'], srcs=glob(['lib/ExecutionEngine/Interpreter/*.c', 'lib/ExecutionEngine/Interpreter/*.cpp', 'lib/ExecutionEngine/Interpreter/*.inc', 'lib/ExecutionEngine/Interpreter/*.h']), hdrs=glob(['include/llvm/ExecutionEngine/Interpreter/*.h', 'include/llvm/ExecutionEngine/Interpreter/*.def', 'include/llvm/ExecutionEngine/Interpreter/*.inc']), copts=llvm_copts)
cc_library(name='JITLink', deps=[':config', ':BinaryFormat', ':Object', ':Support'], srcs=glob(['lib/ExecutionEngine/JITLink/*.c', 'lib/ExecutionEngine/JITLink/*.cpp', 'lib/ExecutionEngine/JITLink/*.inc', 'lib/ExecutionEngine/JITLink/*.h']), hdrs=glob(['include/llvm/ExecutionEngine/JITLink/*.h', 'include/llvm/ExecutionEngine/JITLink/*.def', 'include/llvm/ExecutionEngine/JITLink/*.inc']), copts=llvm_copts)
cc_library(name='LTO', deps=[':config', ':AggressiveInstCombine', ':Analysis', ':BinaryFormat', ':BitReader', ':BitWriter', ':CodeGen', ':Core', ':Extensions', ':IPO', ':InstCombine', ':Linker', ':MC', ':ObjCARC', ':Object', ':Passes', ':Remarks', ':Scalar', ':Support', ':Target', ':TransformUtils'], srcs=glob(['lib/LTO/*.c', 'lib/LTO/*.cpp', 'lib/LTO/*.inc', 'lib/LTO/*.h']), hdrs=glob(['include/llvm/LTO/*.h', 'include/llvm/LTO/*.def', 'include/llvm/LTO/*.inc']), copts=llvm_copts)
cc_library(name='LanaiAsmParser', deps=[':config', ':MC', ':MCParser', ':Support', ':LanaiDesc', ':LanaiInfo'], srcs=glob(['lib/Target/Lanai/AsmParser/*.c', 'lib/Target/Lanai/AsmParser/*.cpp', 'lib/Target/Lanai/AsmParser/*.inc']), hdrs=glob(['include/llvm/Target/Lanai/AsmParser/*.h', 'include/llvm/Target/Lanai/AsmParser/*.def', 'include/llvm/Target/Lanai/AsmParser/*.inc', 'lib/Target/Lanai/AsmParser/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/Lanai'])
cc_library(name='LanaiCodeGen', deps=[':config', ':Analysis', ':AsmPrinter', ':CodeGen', ':Core', ':LanaiAsmParser', ':LanaiDesc', ':LanaiInfo', ':MC', ':SelectionDAG', ':Support', ':Target', ':TransformUtils'], srcs=glob(['lib/Target/Lanai/*.c', 'lib/Target/Lanai/*.cpp', 'lib/Target/Lanai/*.inc']), hdrs=glob(['include/llvm/Target/Lanai/*.h', 'include/llvm/Target/Lanai/*.def', 'include/llvm/Target/Lanai/*.inc', 'lib/Target/Lanai/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/Lanai'])
cc_library(name='LanaiDesc', deps=[':config', ':LanaiInfo', ':MC', ':MCDisassembler', ':Support'], srcs=glob(['lib/Target/Lanai/MCTargetDesc/*.c', 'lib/Target/Lanai/MCTargetDesc/*.cpp', 'lib/Target/Lanai/MCTargetDesc/*.inc']), hdrs=glob(['include/llvm/Target/Lanai/MCTargetDesc/*.h', 'include/llvm/Target/Lanai/MCTargetDesc/*.def', 'include/llvm/Target/Lanai/MCTargetDesc/*.inc', 'lib/Target/Lanai/MCTargetDesc/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/Lanai'])
cc_library(name='LanaiDisassembler', deps=[':config', ':LanaiDesc', ':LanaiInfo', ':MC', ':MCDisassembler', ':Support'], srcs=glob(['lib/Target/Lanai/Disassembler/*.c', 'lib/Target/Lanai/Disassembler/*.cpp', 'lib/Target/Lanai/Disassembler/*.inc']), hdrs=glob(['include/llvm/Target/Lanai/Disassembler/*.h', 'include/llvm/Target/Lanai/Disassembler/*.def', 'include/llvm/Target/Lanai/Disassembler/*.inc', 'lib/Target/Lanai/Disassembler/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/Lanai'])
cc_library(name='LanaiInfo', deps=[':config', ':Support'], srcs=glob(['lib/Target/Lanai/TargetInfo/*.c', 'lib/Target/Lanai/TargetInfo/*.cpp', 'lib/Target/Lanai/TargetInfo/*.inc']), hdrs=glob(['include/llvm/Target/Lanai/TargetInfo/*.h', 'include/llvm/Target/Lanai/TargetInfo/*.def', 'include/llvm/Target/Lanai/TargetInfo/*.inc', 'lib/Target/Lanai/TargetInfo/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/Lanai'])
cc_library(name='LibDriver', deps=[':config', ':BinaryFormat', ':BitReader', ':Object', ':Option', ':Support'], srcs=glob(['lib/ToolDrivers/llvm-lib/*.c', 'lib/ToolDrivers/llvm-lib/*.cpp', 'lib/ToolDrivers/llvm-lib/*.inc', 'lib/ToolDrivers/llvm-lib/*.h']), hdrs=glob(['include/llvm/ToolDrivers/llvm-lib/*.h', 'include/llvm/ToolDrivers/llvm-lib/*.def', 'include/llvm/ToolDrivers/llvm-lib/*.inc']), copts=llvm_copts)
cc_library(name='LineEditor', deps=[':config', ':Support'], srcs=glob(['lib/LineEditor/*.c', 'lib/LineEditor/*.cpp', 'lib/LineEditor/*.inc', 'lib/LineEditor/*.h']), hdrs=glob(['include/llvm/LineEditor/*.h', 'include/llvm/LineEditor/*.def', 'include/llvm/LineEditor/*.inc']), copts=llvm_copts)
cc_library(name='Linker', deps=[':config', ':Core', ':Support', ':TransformUtils'], srcs=glob(['lib/Linker/*.c', 'lib/Linker/*.cpp', 'lib/Linker/*.inc', 'lib/Linker/*.h']), hdrs=glob(['include/llvm/Linker/*.h', 'include/llvm/Linker/*.def', 'include/llvm/Linker/*.inc']), copts=llvm_copts)
cc_library(name='MC', deps=[':config', ':Support', ':BinaryFormat', ':DebugInfoCodeView', ':BinaryFormat', ':DebugInfoCodeView'], srcs=glob(['lib/MC/*.c', 'lib/MC/*.cpp', 'lib/MC/*.inc', 'lib/MC/*.h']), hdrs=glob(['include/llvm/MC/*.h', 'include/llvm/MC/*.def', 'include/llvm/MC/*.inc']), copts=llvm_copts)
cc_library(name='MCA', deps=[':config', ':MC', ':Support'], srcs=glob(['lib/MCA/*.c', 'lib/MCA/*.cpp', 'lib/MCA/*.inc', 'lib/MCA/*.h']), hdrs=glob(['include/llvm/MCA/*.h', 'include/llvm/MCA/*.def', 'include/llvm/MCA/*.inc']), copts=llvm_copts)
cc_library(name='MCDisassembler', deps=[':config', ':MC', ':Support'], srcs=glob(['lib/MC/MCDisassembler/*.c', 'lib/MC/MCDisassembler/*.cpp', 'lib/MC/MCDisassembler/*.inc', 'lib/MC/MCDisassembler/*.h']), hdrs=glob(['include/llvm/MC/MCDisassembler/*.h', 'include/llvm/MC/MCDisassembler/*.def', 'include/llvm/MC/MCDisassembler/*.inc']), copts=llvm_copts)
cc_library(name='MCJIT', deps=[':config', ':Core', ':ExecutionEngine', ':Object', ':RuntimeDyld', ':Support', ':Target'], srcs=glob(['lib/ExecutionEngine/MCJIT/*.c', 'lib/ExecutionEngine/MCJIT/*.cpp', 'lib/ExecutionEngine/MCJIT/*.inc', 'lib/ExecutionEngine/MCJIT/*.h']), hdrs=glob(['include/llvm/ExecutionEngine/MCJIT/*.h', 'include/llvm/ExecutionEngine/MCJIT/*.def', 'include/llvm/ExecutionEngine/MCJIT/*.inc']), copts=llvm_copts)
cc_library(name='MCParser', deps=[':config', ':MC', ':Support'], srcs=glob(['lib/MC/MCParser/*.c', 'lib/MC/MCParser/*.cpp', 'lib/MC/MCParser/*.inc', 'lib/MC/MCParser/*.h']), hdrs=glob(['include/llvm/MC/MCParser/*.h', 'include/llvm/MC/MCParser/*.def', 'include/llvm/MC/MCParser/*.inc']), copts=llvm_copts)
cc_library(name='MIRParser', deps=[':config', ':AsmParser', ':BinaryFormat', ':CodeGen', ':Core', ':MC', ':Support', ':Target'], srcs=glob(['lib/CodeGen/MIRParser/*.c', 'lib/CodeGen/MIRParser/*.cpp', 'lib/CodeGen/MIRParser/*.inc', 'lib/CodeGen/MIRParser/*.h']), hdrs=glob(['include/llvm/CodeGen/MIRParser/*.h', 'include/llvm/CodeGen/MIRParser/*.def', 'include/llvm/CodeGen/MIRParser/*.inc']), copts=llvm_copts)
cc_library(name='MSP430AsmParser', deps=[':config', ':MC', ':MCParser', ':MSP430Desc', ':MSP430Info', ':Support'], srcs=glob(['lib/Target/MSP430/AsmParser/*.c', 'lib/Target/MSP430/AsmParser/*.cpp', 'lib/Target/MSP430/AsmParser/*.inc']), hdrs=glob(['include/llvm/Target/MSP430/AsmParser/*.h', 'include/llvm/Target/MSP430/AsmParser/*.def', 'include/llvm/Target/MSP430/AsmParser/*.inc', 'lib/Target/MSP430/AsmParser/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/MSP430'])
cc_library(name='MSP430CodeGen', deps=[':config', ':AsmPrinter', ':CodeGen', ':Core', ':MC', ':MSP430Desc', ':MSP430Info', ':SelectionDAG', ':Support', ':Target'], srcs=glob(['lib/Target/MSP430/*.c', 'lib/Target/MSP430/*.cpp', 'lib/Target/MSP430/*.inc']), hdrs=glob(['include/llvm/Target/MSP430/*.h', 'include/llvm/Target/MSP430/*.def', 'include/llvm/Target/MSP430/*.inc', 'lib/Target/MSP430/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/MSP430'])
cc_library(name='MSP430Desc', deps=[':config', ':MC', ':MSP430Info', ':Support'], srcs=glob(['lib/Target/MSP430/MCTargetDesc/*.c', 'lib/Target/MSP430/MCTargetDesc/*.cpp', 'lib/Target/MSP430/MCTargetDesc/*.inc']), hdrs=glob(['include/llvm/Target/MSP430/MCTargetDesc/*.h', 'include/llvm/Target/MSP430/MCTargetDesc/*.def', 'include/llvm/Target/MSP430/MCTargetDesc/*.inc', 'lib/Target/MSP430/MCTargetDesc/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/MSP430'])
cc_library(name='MSP430Disassembler', deps=[':config', ':MCDisassembler', ':MSP430Info', ':Support'], srcs=glob(['lib/Target/MSP430/Disassembler/*.c', 'lib/Target/MSP430/Disassembler/*.cpp', 'lib/Target/MSP430/Disassembler/*.inc']), hdrs=glob(['include/llvm/Target/MSP430/Disassembler/*.h', 'include/llvm/Target/MSP430/Disassembler/*.def', 'include/llvm/Target/MSP430/Disassembler/*.inc', 'lib/Target/MSP430/Disassembler/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/MSP430'])
cc_library(name='MSP430Info', deps=[':config', ':Support'], srcs=glob(['lib/Target/MSP430/TargetInfo/*.c', 'lib/Target/MSP430/TargetInfo/*.cpp', 'lib/Target/MSP430/TargetInfo/*.inc']), hdrs=glob(['include/llvm/Target/MSP430/TargetInfo/*.h', 'include/llvm/Target/MSP430/TargetInfo/*.def', 'include/llvm/Target/MSP430/TargetInfo/*.inc', 'lib/Target/MSP430/TargetInfo/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/MSP430'])
cc_library(name='MipsAsmParser', deps=[':config', ':MC', ':MCParser', ':MipsDesc', ':MipsInfo', ':Support'], srcs=glob(['lib/Target/Mips/AsmParser/*.c', 'lib/Target/Mips/AsmParser/*.cpp', 'lib/Target/Mips/AsmParser/*.inc']), hdrs=glob(['include/llvm/Target/Mips/AsmParser/*.h', 'include/llvm/Target/Mips/AsmParser/*.def', 'include/llvm/Target/Mips/AsmParser/*.inc', 'lib/Target/Mips/AsmParser/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/Mips'])
cc_library(name='MipsCodeGen', deps=[':config', ':Analysis', ':AsmPrinter', ':CodeGen', ':Core', ':MC', ':MipsDesc', ':MipsInfo', ':SelectionDAG', ':Support', ':Target', ':GlobalISel'], srcs=glob(['lib/Target/Mips/*.c', 'lib/Target/Mips/*.cpp', 'lib/Target/Mips/*.inc']), hdrs=glob(['include/llvm/Target/Mips/*.h', 'include/llvm/Target/Mips/*.def', 'include/llvm/Target/Mips/*.inc', 'lib/Target/Mips/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/Mips'])
cc_library(name='MipsDesc', deps=[':config', ':MC', ':MipsInfo', ':Support'], srcs=glob(['lib/Target/Mips/MCTargetDesc/*.c', 'lib/Target/Mips/MCTargetDesc/*.cpp', 'lib/Target/Mips/MCTargetDesc/*.inc']), hdrs=glob(['include/llvm/Target/Mips/MCTargetDesc/*.h', 'include/llvm/Target/Mips/MCTargetDesc/*.def', 'include/llvm/Target/Mips/MCTargetDesc/*.inc', 'lib/Target/Mips/MCTargetDesc/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/Mips'])
cc_library(name='MipsDisassembler', deps=[':config', ':MCDisassembler', ':MipsInfo', ':Support'], srcs=glob(['lib/Target/Mips/Disassembler/*.c', 'lib/Target/Mips/Disassembler/*.cpp', 'lib/Target/Mips/Disassembler/*.inc']), hdrs=glob(['include/llvm/Target/Mips/Disassembler/*.h', 'include/llvm/Target/Mips/Disassembler/*.def', 'include/llvm/Target/Mips/Disassembler/*.inc', 'lib/Target/Mips/Disassembler/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/Mips'])
cc_library(name='MipsInfo', deps=[':config', ':Support'], srcs=glob(['lib/Target/Mips/TargetInfo/*.c', 'lib/Target/Mips/TargetInfo/*.cpp', 'lib/Target/Mips/TargetInfo/*.inc']), hdrs=glob(['include/llvm/Target/Mips/TargetInfo/*.h', 'include/llvm/Target/Mips/TargetInfo/*.def', 'include/llvm/Target/Mips/TargetInfo/*.inc', 'lib/Target/Mips/TargetInfo/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/Mips'])
cc_library(name='NVPTXCodeGen', deps=[':config', ':Analysis', ':AsmPrinter', ':CodeGen', ':Core', ':IPO', ':MC', ':NVPTXDesc', ':NVPTXInfo', ':Scalar', ':SelectionDAG', ':Support', ':Target', ':TransformUtils', ':Vectorize'], srcs=glob(['lib/Target/NVPTX/*.c', 'lib/Target/NVPTX/*.cpp', 'lib/Target/NVPTX/*.inc']), hdrs=glob(['include/llvm/Target/NVPTX/*.h', 'include/llvm/Target/NVPTX/*.def', 'include/llvm/Target/NVPTX/*.inc', 'lib/Target/NVPTX/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/NVPTX'])
cc_library(name='NVPTXDesc', deps=[':config', ':MC', ':NVPTXInfo', ':Support', ':NVPTXCommonTableGen'], srcs=glob(['lib/Target/NVPTX/MCTargetDesc/*.c', 'lib/Target/NVPTX/MCTargetDesc/*.cpp', 'lib/Target/NVPTX/MCTargetDesc/*.inc']), hdrs=glob(['include/llvm/Target/NVPTX/MCTargetDesc/*.h', 'include/llvm/Target/NVPTX/MCTargetDesc/*.def', 'include/llvm/Target/NVPTX/MCTargetDesc/*.inc', 'lib/Target/NVPTX/MCTargetDesc/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/NVPTX'])
cc_library(name='NVPTXInfo', deps=[':config', ':Support', ':NVPTXCommonTableGen', ':attributes_gen', ':Core', ':Target'], srcs=glob(['lib/Target/NVPTX/TargetInfo/*.c', 'lib/Target/NVPTX/TargetInfo/*.cpp', 'lib/Target/NVPTX/TargetInfo/*.inc', 'lib/Target/NVPTX/MCTargetDesc/*.h']), hdrs=glob(['include/llvm/Target/NVPTX/TargetInfo/*.h', 'include/llvm/Target/NVPTX/TargetInfo/*.def', 'include/llvm/Target/NVPTX/TargetInfo/*.inc', 'lib/Target/NVPTX/NVPTX.h', 'lib/Target/NVPTX/TargetInfo/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/NVPTX'])
cc_library(name='ObjCARC', deps=[':config', ':Analysis', ':Core', ':Support', ':TransformUtils'], srcs=glob(['lib/Transforms/ObjCARC/*.c', 'lib/Transforms/ObjCARC/*.cpp', 'lib/Transforms/ObjCARC/*.inc', 'include/llvm/Transforms/ObjCARC.h', 'lib/Transforms/ObjCARC/*.h']), hdrs=glob(['include/llvm/Transforms/ObjCARC/*.h', 'include/llvm/Transforms/ObjCARC/*.def', 'include/llvm/Transforms/ObjCARC/*.inc']), copts=llvm_copts)
cc_library(name='Object', deps=[':config', ':BitReader', ':Core', ':MC', ':BinaryFormat', ':MCParser', ':Support', ':TextAPI'], srcs=glob(['lib/Object/*.c', 'lib/Object/*.cpp', 'lib/Object/*.inc', 'lib/Object/*.h']), hdrs=glob(['include/llvm/Object/*.h', 'include/llvm/Object/*.def', 'include/llvm/Object/*.inc']), copts=llvm_copts)
cc_library(name='ObjectYAML', deps=[':config', ':BinaryFormat', ':Object', ':Support', ':DebugInfoCodeView', ':MC'], srcs=glob(['lib/ObjectYAML/*.c', 'lib/ObjectYAML/*.cpp', 'lib/ObjectYAML/*.inc', 'lib/ObjectYAML/*.h']), hdrs=glob(['include/llvm/ObjectYAML/*.h', 'include/llvm/ObjectYAML/*.def', 'include/llvm/ObjectYAML/*.inc']), copts=llvm_copts)
cc_library(name='Option', deps=[':config', ':Support'], srcs=glob(['lib/Option/*.c', 'lib/Option/*.cpp', 'lib/Option/*.inc', 'lib/Option/*.h']), hdrs=glob(['include/llvm/Option/*.h', 'include/llvm/Option/*.def', 'include/llvm/Option/*.inc']), copts=llvm_copts)
cc_library(name='OrcError', deps=[':config', ':Support'], srcs=glob(['lib/ExecutionEngine/OrcError/*.c', 'lib/ExecutionEngine/OrcError/*.cpp', 'lib/ExecutionEngine/OrcError/*.inc', 'lib/ExecutionEngine/OrcError/*.h']), hdrs=glob(['include/llvm/ExecutionEngine/OrcError/*.h', 'include/llvm/ExecutionEngine/OrcError/*.def', 'include/llvm/ExecutionEngine/OrcError/*.inc']), copts=llvm_copts)
cc_library(name='OrcJIT', deps=[':config', ':Core', ':ExecutionEngine', ':JITLink', ':Object', ':OrcError', ':MC', ':Passes', ':RuntimeDyld', ':Support', ':Target', ':TransformUtils'], srcs=glob(['lib/ExecutionEngine/Orc/*.c', 'lib/ExecutionEngine/Orc/*.cpp', 'lib/ExecutionEngine/Orc/*.inc', 'lib/ExecutionEngine/Orc/*.h']), hdrs=glob(['include/llvm/ExecutionEngine/Orc/*.h', 'include/llvm/ExecutionEngine/Orc/*.def', 'include/llvm/ExecutionEngine/Orc/*.inc']), copts=llvm_copts)
cc_library(name='Passes', deps=[':config', ':AggressiveInstCombine', ':Analysis', ':Core', ':Coroutines', ':IPO', ':InstCombine', ':Scalar', ':Support', ':Target', ':TransformUtils', ':Vectorize', ':Instrumentation', ':CodeGen'], srcs=glob(['lib/Passes/*.c', 'lib/Passes/*.cpp', 'lib/Passes/*.inc', 'lib/Passes/*.h']), hdrs=glob(['include/llvm/Passes/*.h', 'include/llvm/Passes/*.def', 'include/llvm/Passes/*.inc']), copts=llvm_copts)
cc_library(name='PowerPCAsmParser', deps=[':config', ':MC', ':MCParser', ':PowerPCDesc', ':PowerPCInfo', ':Support'], srcs=glob(['lib/Target/PowerPC/AsmParser/*.c', 'lib/Target/PowerPC/AsmParser/*.cpp', 'lib/Target/PowerPC/AsmParser/*.inc']), hdrs=glob(['include/llvm/Target/PowerPC/AsmParser/*.h', 'include/llvm/Target/PowerPC/AsmParser/*.def', 'include/llvm/Target/PowerPC/AsmParser/*.inc', 'lib/Target/PowerPC/AsmParser/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/PowerPC'])
cc_library(name='PowerPCCodeGen', deps=[':config', ':Analysis', ':AsmPrinter', ':CodeGen', ':Core', ':MC', ':PowerPCDesc', ':PowerPCInfo', ':Scalar', ':SelectionDAG', ':Support', ':Target', ':TransformUtils'], srcs=glob(['lib/Target/PowerPC/*.c', 'lib/Target/PowerPC/*.cpp', 'lib/Target/PowerPC/*.inc']), hdrs=glob(['include/llvm/Target/PowerPC/*.h', 'include/llvm/Target/PowerPC/*.def', 'include/llvm/Target/PowerPC/*.inc', 'lib/Target/PowerPC/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/PowerPC'])
cc_library(name='PowerPCDesc', deps=[':config', ':MC', ':PowerPCInfo', ':Support', ':BinaryFormat', ':PowerPCCommonTableGen', ':attributes_gen', ':intrinsic_enums_gen', ':intrinsics_impl_gen'], srcs=glob(['lib/Target/PowerPC/MCTargetDesc/*.c', 'lib/Target/PowerPC/MCTargetDesc/*.cpp', 'lib/Target/PowerPC/MCTargetDesc/*.inc']), hdrs=glob(['include/llvm/Target/PowerPC/MCTargetDesc/*.h', 'include/llvm/Target/PowerPC/MCTargetDesc/*.def', 'include/llvm/Target/PowerPC/MCTargetDesc/*.inc', 'lib/Target/PowerPC/MCTargetDesc/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/PowerPC'])
cc_library(name='PowerPCDisassembler', deps=[':config', ':MCDisassembler', ':PowerPCInfo', ':Support'], srcs=glob(['lib/Target/PowerPC/Disassembler/*.c', 'lib/Target/PowerPC/Disassembler/*.cpp', 'lib/Target/PowerPC/Disassembler/*.inc']), hdrs=glob(['include/llvm/Target/PowerPC/Disassembler/*.h', 'include/llvm/Target/PowerPC/Disassembler/*.def', 'include/llvm/Target/PowerPC/Disassembler/*.inc', 'lib/Target/PowerPC/Disassembler/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/PowerPC'])
cc_library(name='PowerPCInfo', deps=[':config', ':Support', ':PowerPCCommonTableGen', ':attributes_gen', ':Core', ':Target'], srcs=glob(['lib/Target/PowerPC/TargetInfo/*.c', 'lib/Target/PowerPC/TargetInfo/*.cpp', 'lib/Target/PowerPC/TargetInfo/*.inc', 'lib/Target/PowerPC/MCTargetDesc/*.h']), hdrs=glob(['include/llvm/Target/PowerPC/TargetInfo/*.h', 'include/llvm/Target/PowerPC/TargetInfo/*.def', 'include/llvm/Target/PowerPC/TargetInfo/*.inc', 'lib/Target/PowerPC/PPC*.h', 'lib/Target/PowerPC/TargetInfo/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/PowerPC'])
cc_library(name='ProfileData', deps=[':config', ':Core', ':Support'], srcs=glob(['lib/ProfileData/*.c', 'lib/ProfileData/*.cpp', 'lib/ProfileData/*.inc', 'lib/ProfileData/*.h']), hdrs=glob(['include/llvm/ProfileData/*.h', 'include/llvm/ProfileData/*.def', 'include/llvm/ProfileData/*.inc']), copts=llvm_copts)
cc_library(name='RISCVAsmParser', deps=[':config', ':MC', ':MCParser', ':RISCVDesc', ':RISCVInfo', ':RISCVUtils', ':Support'], srcs=glob(['lib/Target/RISCV/AsmParser/*.c', 'lib/Target/RISCV/AsmParser/*.cpp', 'lib/Target/RISCV/AsmParser/*.inc']), hdrs=glob(['include/llvm/Target/RISCV/AsmParser/*.h', 'include/llvm/Target/RISCV/AsmParser/*.def', 'include/llvm/Target/RISCV/AsmParser/*.inc', 'lib/Target/RISCV/AsmParser/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/RISCV'])
cc_library(name='RISCVCodeGen', deps=[':config', ':Analysis', ':AsmPrinter', ':Core', ':CodeGen', ':MC', ':RISCVDesc', ':RISCVInfo', ':RISCVUtils', ':SelectionDAG', ':Support', ':Target', ':GlobalISel'], srcs=glob(['lib/Target/RISCV/*.c', 'lib/Target/RISCV/*.cpp', 'lib/Target/RISCV/*.inc']), hdrs=glob(['include/llvm/Target/RISCV/*.h', 'include/llvm/Target/RISCV/*.def', 'include/llvm/Target/RISCV/*.inc', 'lib/Target/RISCV/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/RISCV'])
cc_library(name='RISCVDesc', deps=[':config', ':MC', ':RISCVInfo', ':RISCVUtils', ':Support'], srcs=glob(['lib/Target/RISCV/MCTargetDesc/*.c', 'lib/Target/RISCV/MCTargetDesc/*.cpp', 'lib/Target/RISCV/MCTargetDesc/*.inc']), hdrs=glob(['include/llvm/Target/RISCV/MCTargetDesc/*.h', 'include/llvm/Target/RISCV/MCTargetDesc/*.def', 'include/llvm/Target/RISCV/MCTargetDesc/*.inc', 'lib/Target/RISCV/MCTargetDesc/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/RISCV'])
cc_library(name='RISCVDisassembler', deps=[':config', ':MCDisassembler', ':RISCVInfo', ':Support'], srcs=glob(['lib/Target/RISCV/Disassembler/*.c', 'lib/Target/RISCV/Disassembler/*.cpp', 'lib/Target/RISCV/Disassembler/*.inc']), hdrs=glob(['include/llvm/Target/RISCV/Disassembler/*.h', 'include/llvm/Target/RISCV/Disassembler/*.def', 'include/llvm/Target/RISCV/Disassembler/*.inc', 'lib/Target/RISCV/Disassembler/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/RISCV'])
cc_library(name='RISCVInfo', deps=[':config', ':Support'], srcs=glob(['lib/Target/RISCV/TargetInfo/*.c', 'lib/Target/RISCV/TargetInfo/*.cpp', 'lib/Target/RISCV/TargetInfo/*.inc']), hdrs=glob(['include/llvm/Target/RISCV/TargetInfo/*.h', 'include/llvm/Target/RISCV/TargetInfo/*.def', 'include/llvm/Target/RISCV/TargetInfo/*.inc', 'lib/Target/RISCV/TargetInfo/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/RISCV'])
cc_library(name='RISCVUtils', deps=[':config', ':Support'], srcs=glob(['lib/Target/RISCV/Utils/*.c', 'lib/Target/RISCV/Utils/*.cpp', 'lib/Target/RISCV/Utils/*.inc']), hdrs=glob(['include/llvm/Target/RISCV/Utils/*.h', 'include/llvm/Target/RISCV/Utils/*.def', 'include/llvm/Target/RISCV/Utils/*.inc', 'lib/Target/RISCV/Utils/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/RISCV'])
cc_library(name='Remarks', deps=[':config', ':BitstreamReader', ':Support'], srcs=glob(['lib/Remarks/*.c', 'lib/Remarks/*.cpp', 'lib/Remarks/*.inc', 'lib/Remarks/*.h']), hdrs=glob(['include/llvm/Remarks/*.h', 'include/llvm/Remarks/*.def', 'include/llvm/Remarks/*.inc']), copts=llvm_copts)
cc_library(name='RuntimeDyld', deps=[':config', ':Core', ':MC', ':Object', ':Support', ':MCDisassembler'], srcs=glob(['lib/ExecutionEngine/RuntimeDyld/*.c', 'lib/ExecutionEngine/RuntimeDyld/*.cpp', 'lib/ExecutionEngine/RuntimeDyld/*.inc', 'include/llvm/ExecutionEngine/JITSymbol.h', 'include/llvm/ExecutionEngine/RTDyldMemoryManager.h', 'lib/ExecutionEngine/RuntimeDyld/*.h', 'lib/ExecutionEngine/RuntimeDyld/Targets/*.h', 'lib/ExecutionEngine/RuntimeDyld/Targets/*.cpp', 'lib/ExecutionEngine/RuntimeDyld/*.h']), hdrs=glob(['include/llvm/ExecutionEngine/RuntimeDyld/*.h', 'include/llvm/ExecutionEngine/RuntimeDyld/*.def', 'include/llvm/ExecutionEngine/RuntimeDyld/*.inc', 'include/llvm/DebugInfo/DIContext.h', 'include/llvm/ExecutionEngine/RTDyldMemoryManager.h', 'include/llvm/ExecutionEngine/RuntimeDyld*.h']), copts=llvm_copts)
cc_library(name='Scalar', deps=[':config', ':AggressiveInstCombine', ':Analysis', ':Core', ':InstCombine', ':Support', ':TransformUtils', ':Target'], srcs=glob(['lib/Transforms/Scalar/*.c', 'lib/Transforms/Scalar/*.cpp', 'lib/Transforms/Scalar/*.inc', 'include/llvm-c/Transforms/Scalar.h', 'include/llvm/Transforms/Scalar.h', 'include/llvm/Target/TargetMachine.h', 'lib/Transforms/Scalar/*.h']), hdrs=glob(['include/llvm/Transforms/Scalar/*.h', 'include/llvm/Transforms/Scalar/*.def', 'include/llvm/Transforms/Scalar/*.inc', 'include/llvm/Transforms/IPO.h', 'include/llvm/Transforms/IPO/SCCP.h']), copts=llvm_copts)
cc_library(name='SelectionDAG', deps=[':config', ':Analysis', ':CodeGen', ':Core', ':MC', ':Support', ':Target', ':TransformUtils'], srcs=glob(['lib/CodeGen/SelectionDAG/*.c', 'lib/CodeGen/SelectionDAG/*.cpp', 'lib/CodeGen/SelectionDAG/*.inc', 'lib/CodeGen/SelectionDAG/*.h']), hdrs=glob(['include/llvm/CodeGen/SelectionDAG/*.h', 'include/llvm/CodeGen/SelectionDAG/*.def', 'include/llvm/CodeGen/SelectionDAG/*.inc']), copts=llvm_copts)
cc_library(name='SparcAsmParser', deps=[':config', ':MC', ':MCParser', ':SparcDesc', ':SparcInfo', ':Support'], srcs=glob(['lib/Target/Sparc/AsmParser/*.c', 'lib/Target/Sparc/AsmParser/*.cpp', 'lib/Target/Sparc/AsmParser/*.inc']), hdrs=glob(['include/llvm/Target/Sparc/AsmParser/*.h', 'include/llvm/Target/Sparc/AsmParser/*.def', 'include/llvm/Target/Sparc/AsmParser/*.inc', 'lib/Target/Sparc/AsmParser/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/Sparc'])
cc_library(name='SparcCodeGen', deps=[':config', ':AsmPrinter', ':CodeGen', ':Core', ':MC', ':SelectionDAG', ':SparcDesc', ':SparcInfo', ':Support', ':Target'], srcs=glob(['lib/Target/Sparc/*.c', 'lib/Target/Sparc/*.cpp', 'lib/Target/Sparc/*.inc']), hdrs=glob(['include/llvm/Target/Sparc/*.h', 'include/llvm/Target/Sparc/*.def', 'include/llvm/Target/Sparc/*.inc', 'lib/Target/Sparc/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/Sparc'])
cc_library(name='SparcDesc', deps=[':config', ':MC', ':SparcInfo', ':Support'], srcs=glob(['lib/Target/Sparc/MCTargetDesc/*.c', 'lib/Target/Sparc/MCTargetDesc/*.cpp', 'lib/Target/Sparc/MCTargetDesc/*.inc']), hdrs=glob(['include/llvm/Target/Sparc/MCTargetDesc/*.h', 'include/llvm/Target/Sparc/MCTargetDesc/*.def', 'include/llvm/Target/Sparc/MCTargetDesc/*.inc', 'lib/Target/Sparc/MCTargetDesc/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/Sparc'])
cc_library(name='SparcDisassembler', deps=[':config', ':MCDisassembler', ':SparcInfo', ':Support'], srcs=glob(['lib/Target/Sparc/Disassembler/*.c', 'lib/Target/Sparc/Disassembler/*.cpp', 'lib/Target/Sparc/Disassembler/*.inc']), hdrs=glob(['include/llvm/Target/Sparc/Disassembler/*.h', 'include/llvm/Target/Sparc/Disassembler/*.def', 'include/llvm/Target/Sparc/Disassembler/*.inc', 'lib/Target/Sparc/Disassembler/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/Sparc'])
cc_library(name='SparcInfo', deps=[':config', ':Support'], srcs=glob(['lib/Target/Sparc/TargetInfo/*.c', 'lib/Target/Sparc/TargetInfo/*.cpp', 'lib/Target/Sparc/TargetInfo/*.inc']), hdrs=glob(['include/llvm/Target/Sparc/TargetInfo/*.h', 'include/llvm/Target/Sparc/TargetInfo/*.def', 'include/llvm/Target/Sparc/TargetInfo/*.inc', 'lib/Target/Sparc/TargetInfo/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/Sparc'])
cc_library(name='Support', deps=[':config', ':Demangle', '@zlib'], srcs=glob(['lib/Support/*.c', 'lib/Support/*.cpp', 'lib/Support/*.inc', 'include/llvm-c/*.h', 'include/llvm/CodeGen/MachineValueType.h', 'include/llvm/BinaryFormat/COFF.h', 'include/llvm/BinaryFormat/MachO.h', 'lib/Support/*.h']) + llvm_support_platform_specific_srcs_glob(), hdrs=glob(['include/llvm/Support/*.h', 'include/llvm/Support/*.def', 'include/llvm/Support/*.inc', 'include/llvm/ADT/*.h', 'include/llvm/Support/ELFRelocs/*.def', 'include/llvm/Support/WasmRelocs/*.def']) + ['include/llvm/BinaryFormat/MachO.def', 'include/llvm/Support/VCSRevision.h'], copts=llvm_copts)
cc_library(name='Symbolize', deps=[':config', ':DebugInfoDWARF', ':DebugInfoPDB', ':Object', ':Support', ':Demangle'], srcs=glob(['lib/DebugInfo/Symbolize/*.c', 'lib/DebugInfo/Symbolize/*.cpp', 'lib/DebugInfo/Symbolize/*.inc', 'lib/DebugInfo/Symbolize/*.h']), hdrs=glob(['include/llvm/DebugInfo/Symbolize/*.h', 'include/llvm/DebugInfo/Symbolize/*.def', 'include/llvm/DebugInfo/Symbolize/*.inc']), copts=llvm_copts)
cc_library(name='SystemZAsmParser', deps=[':config', ':MC', ':MCParser', ':Support', ':SystemZDesc', ':SystemZInfo'], srcs=glob(['lib/Target/SystemZ/AsmParser/*.c', 'lib/Target/SystemZ/AsmParser/*.cpp', 'lib/Target/SystemZ/AsmParser/*.inc']), hdrs=glob(['include/llvm/Target/SystemZ/AsmParser/*.h', 'include/llvm/Target/SystemZ/AsmParser/*.def', 'include/llvm/Target/SystemZ/AsmParser/*.inc', 'lib/Target/SystemZ/AsmParser/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/SystemZ'])
cc_library(name='SystemZCodeGen', deps=[':config', ':Analysis', ':AsmPrinter', ':CodeGen', ':Core', ':MC', ':Scalar', ':SelectionDAG', ':Support', ':SystemZDesc', ':SystemZInfo', ':Target'], srcs=glob(['lib/Target/SystemZ/*.c', 'lib/Target/SystemZ/*.cpp', 'lib/Target/SystemZ/*.inc']), hdrs=glob(['include/llvm/Target/SystemZ/*.h', 'include/llvm/Target/SystemZ/*.def', 'include/llvm/Target/SystemZ/*.inc', 'lib/Target/SystemZ/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/SystemZ'])
cc_library(name='SystemZDesc', deps=[':config', ':MC', ':Support', ':SystemZInfo', ':SystemZCommonTableGen'], srcs=glob(['lib/Target/SystemZ/MCTargetDesc/*.c', 'lib/Target/SystemZ/MCTargetDesc/*.cpp', 'lib/Target/SystemZ/MCTargetDesc/*.inc']), hdrs=glob(['include/llvm/Target/SystemZ/MCTargetDesc/*.h', 'include/llvm/Target/SystemZ/MCTargetDesc/*.def', 'include/llvm/Target/SystemZ/MCTargetDesc/*.inc', 'lib/Target/SystemZ/MCTargetDesc/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/SystemZ'])
cc_library(name='SystemZDisassembler', deps=[':config', ':MC', ':MCDisassembler', ':Support', ':SystemZDesc', ':SystemZInfo'], srcs=glob(['lib/Target/SystemZ/Disassembler/*.c', 'lib/Target/SystemZ/Disassembler/*.cpp', 'lib/Target/SystemZ/Disassembler/*.inc']), hdrs=glob(['include/llvm/Target/SystemZ/Disassembler/*.h', 'include/llvm/Target/SystemZ/Disassembler/*.def', 'include/llvm/Target/SystemZ/Disassembler/*.inc', 'lib/Target/SystemZ/Disassembler/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/SystemZ'])
cc_library(name='SystemZInfo', deps=[':config', ':Support', ':SystemZCommonTableGen'], srcs=glob(['lib/Target/SystemZ/TargetInfo/*.c', 'lib/Target/SystemZ/TargetInfo/*.cpp', 'lib/Target/SystemZ/TargetInfo/*.inc', 'lib/Target/SystemZ/MCTargetDesc/*.h']), hdrs=glob(['include/llvm/Target/SystemZ/TargetInfo/*.h', 'include/llvm/Target/SystemZ/TargetInfo/*.def', 'include/llvm/Target/SystemZ/TargetInfo/*.inc', 'lib/Target/SystemZ/TargetInfo/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/SystemZ'])
cc_library(name='TableGen', deps=[':config', ':Support', ':MC'], srcs=glob(['lib/TableGen/*.c', 'lib/TableGen/*.cpp', 'lib/TableGen/*.inc', 'include/llvm/CodeGen/*.h', 'lib/TableGen/*.h']), hdrs=glob(['include/llvm/TableGen/*.h', 'include/llvm/TableGen/*.def', 'include/llvm/TableGen/*.inc', 'include/llvm/Target/*.def']), copts=llvm_copts)
cc_library(name='Target', deps=[':config', ':Analysis', ':Core', ':MC', ':Support'], srcs=glob(['lib/Target/*.c', 'lib/Target/*.cpp', 'lib/Target/*.inc', 'include/llvm/CodeGen/*.h', 'include/llvm-c/Initialization.h', 'include/llvm-c/Target.h', 'lib/Target/*.h']), hdrs=glob(['include/llvm/Target/*.h', 'include/llvm/Target/*.def', 'include/llvm/Target/*.inc', 'include/llvm/CodeGen/*.def', 'include/llvm/CodeGen/*.inc']), copts=llvm_copts)
cc_library(name='TestingSupport', deps=[':config', ':Support'], srcs=glob(['lib/Testing/Support/*.c', 'lib/Testing/Support/*.cpp', 'lib/Testing/Support/*.inc', 'lib/Testing/Support/*.h']), hdrs=glob(['include/llvm/Testing/Support/*.h', 'include/llvm/Testing/Support/*.def', 'include/llvm/Testing/Support/*.inc']), copts=llvm_copts)
cc_library(name='TextAPI', deps=[':config', ':Support', ':BinaryFormat'], srcs=glob(['lib/TextAPI/*.c', 'lib/TextAPI/*.cpp', 'lib/TextAPI/*.inc', 'lib/TextAPI/ELF/*.cpp', 'lib/TextAPI/MachO/*.cpp', 'lib/TextAPI/MachO/*.h', 'lib/TextAPI/*.h']), hdrs=glob(['include/llvm/TextAPI/*.h', 'include/llvm/TextAPI/*.def', 'include/llvm/TextAPI/*.inc']) + ['include/llvm/TextAPI/MachO/Architecture.def', 'include/llvm/TextAPI/MachO/PackedVersion.h', 'include/llvm/TextAPI/MachO/InterfaceFile.h', 'include/llvm/TextAPI/MachO/Symbol.h', 'include/llvm/TextAPI/MachO/ArchitectureSet.h', 'include/llvm/TextAPI/MachO/TextAPIWriter.h', 'include/llvm/TextAPI/MachO/TextAPIReader.h', 'include/llvm/TextAPI/MachO/Architecture.h'], copts=llvm_copts)
cc_library(name='TransformUtils', deps=[':config', ':Analysis', ':Core', ':Support'], srcs=glob(['lib/Transforms/Utils/*.c', 'lib/Transforms/Utils/*.cpp', 'lib/Transforms/Utils/*.inc', 'include/llvm/Transforms/IPO.h', 'include/llvm/Transforms/Scalar.h', 'lib/Transforms/Utils/*.h']), hdrs=glob(['include/llvm/Transforms/Utils/*.h', 'include/llvm/Transforms/Utils/*.def', 'include/llvm/Transforms/Utils/*.inc']), copts=llvm_copts)
cc_library(name='VEAsmParser', deps=[':config', ':MC', ':MCParser', ':VEDesc', ':VEInfo', ':Support'], srcs=glob(['lib/Target/VE/AsmParser/*.c', 'lib/Target/VE/AsmParser/*.cpp', 'lib/Target/VE/AsmParser/*.inc']), hdrs=glob(['include/llvm/Target/VE/AsmParser/*.h', 'include/llvm/Target/VE/AsmParser/*.def', 'include/llvm/Target/VE/AsmParser/*.inc', 'lib/Target/VE/AsmParser/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/VE'])
cc_library(name='VECodeGen', deps=[':config', ':Analysis', ':AsmPrinter', ':CodeGen', ':Core', ':MC', ':SelectionDAG', ':VEDesc', ':VEInfo', ':Support', ':Target'], srcs=glob(['lib/Target/VE/*.c', 'lib/Target/VE/*.cpp', 'lib/Target/VE/*.inc']), hdrs=glob(['include/llvm/Target/VE/*.h', 'include/llvm/Target/VE/*.def', 'include/llvm/Target/VE/*.inc', 'lib/Target/VE/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/VE'])
cc_library(name='VEDesc', deps=[':config', ':MC', ':VEInfo', ':Support'], srcs=glob(['lib/Target/VE/MCTargetDesc/*.c', 'lib/Target/VE/MCTargetDesc/*.cpp', 'lib/Target/VE/MCTargetDesc/*.inc']), hdrs=glob(['include/llvm/Target/VE/MCTargetDesc/*.h', 'include/llvm/Target/VE/MCTargetDesc/*.def', 'include/llvm/Target/VE/MCTargetDesc/*.inc', 'lib/Target/VE/MCTargetDesc/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/VE'])
cc_library(name='VEDisassembler', deps=[':config', ':MCDisassembler', ':VEInfo', ':Support'], srcs=glob(['lib/Target/VE/Disassembler/*.c', 'lib/Target/VE/Disassembler/*.cpp', 'lib/Target/VE/Disassembler/*.inc']), hdrs=glob(['include/llvm/Target/VE/Disassembler/*.h', 'include/llvm/Target/VE/Disassembler/*.def', 'include/llvm/Target/VE/Disassembler/*.inc', 'lib/Target/VE/Disassembler/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/VE'])
cc_library(name='VEInfo', deps=[':config', ':Support'], srcs=glob(['lib/Target/VE/TargetInfo/*.c', 'lib/Target/VE/TargetInfo/*.cpp', 'lib/Target/VE/TargetInfo/*.inc']), hdrs=glob(['include/llvm/Target/VE/TargetInfo/*.h', 'include/llvm/Target/VE/TargetInfo/*.def', 'include/llvm/Target/VE/TargetInfo/*.inc', 'lib/Target/VE/TargetInfo/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/VE'])
cc_library(name='Vectorize', deps=[':config', ':Analysis', ':Core', ':Support', ':TransformUtils', ':Scalar'], srcs=glob(['lib/Transforms/Vectorize/*.c', 'lib/Transforms/Vectorize/*.cpp', 'lib/Transforms/Vectorize/*.inc', 'include/llvm-c/Transforms/Vectorize.h', 'lib/Transforms/Vectorize/*.h']), hdrs=glob(['include/llvm/Transforms/Vectorize/*.h', 'include/llvm/Transforms/Vectorize/*.def', 'include/llvm/Transforms/Vectorize/*.inc', 'include/llvm/Transforms/Vectorize.h']), copts=llvm_copts)
cc_library(name='WebAssemblyAsmParser', deps=[':config', ':MC', ':MCParser', ':WebAssemblyInfo', ':Support'], srcs=glob(['lib/Target/WebAssembly/AsmParser/*.c', 'lib/Target/WebAssembly/AsmParser/*.cpp', 'lib/Target/WebAssembly/AsmParser/*.inc']), hdrs=glob(['include/llvm/Target/WebAssembly/AsmParser/*.h', 'include/llvm/Target/WebAssembly/AsmParser/*.def', 'include/llvm/Target/WebAssembly/AsmParser/*.inc', 'lib/Target/WebAssembly/AsmParser/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/WebAssembly'])
cc_library(name='WebAssemblyCodeGen', deps=[':config', ':Analysis', ':AsmPrinter', ':BinaryFormat', ':CodeGen', ':Core', ':MC', ':Scalar', ':SelectionDAG', ':Support', ':Target', ':TransformUtils', ':WebAssemblyDesc', ':WebAssemblyInfo'], srcs=glob(['lib/Target/WebAssembly/*.c', 'lib/Target/WebAssembly/*.cpp', 'lib/Target/WebAssembly/*.inc']), hdrs=glob(['include/llvm/Target/WebAssembly/*.h', 'include/llvm/Target/WebAssembly/*.def', 'include/llvm/Target/WebAssembly/*.inc', 'lib/Target/WebAssembly/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/WebAssembly'])
cc_library(name='WebAssemblyDesc', deps=[':config', ':MC', ':Support', ':WebAssemblyInfo'], srcs=glob(['lib/Target/WebAssembly/MCTargetDesc/*.c', 'lib/Target/WebAssembly/MCTargetDesc/*.cpp', 'lib/Target/WebAssembly/MCTargetDesc/*.inc']), hdrs=glob(['include/llvm/Target/WebAssembly/MCTargetDesc/*.h', 'include/llvm/Target/WebAssembly/MCTargetDesc/*.def', 'include/llvm/Target/WebAssembly/MCTargetDesc/*.inc', 'lib/Target/WebAssembly/MCTargetDesc/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/WebAssembly'])
cc_library(name='WebAssemblyDisassembler', deps=[':config', ':WebAssemblyDesc', ':MCDisassembler', ':WebAssemblyInfo', ':Support', ':MC'], srcs=glob(['lib/Target/WebAssembly/Disassembler/*.c', 'lib/Target/WebAssembly/Disassembler/*.cpp', 'lib/Target/WebAssembly/Disassembler/*.inc']), hdrs=glob(['include/llvm/Target/WebAssembly/Disassembler/*.h', 'include/llvm/Target/WebAssembly/Disassembler/*.def', 'include/llvm/Target/WebAssembly/Disassembler/*.inc', 'lib/Target/WebAssembly/Disassembler/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/WebAssembly'])
cc_library(name='WebAssemblyInfo', deps=[':config', ':Support'], srcs=glob(['lib/Target/WebAssembly/TargetInfo/*.c', 'lib/Target/WebAssembly/TargetInfo/*.cpp', 'lib/Target/WebAssembly/TargetInfo/*.inc']), hdrs=glob(['include/llvm/Target/WebAssembly/TargetInfo/*.h', 'include/llvm/Target/WebAssembly/TargetInfo/*.def', 'include/llvm/Target/WebAssembly/TargetInfo/*.inc', 'lib/Target/WebAssembly/TargetInfo/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/WebAssembly'])
cc_library(name='WindowsManifest', deps=[':config', ':Support'], srcs=glob(['lib/WindowsManifest/*.c', 'lib/WindowsManifest/*.cpp', 'lib/WindowsManifest/*.inc', 'lib/WindowsManifest/*.h']), hdrs=glob(['include/llvm/WindowsManifest/*.h', 'include/llvm/WindowsManifest/*.def', 'include/llvm/WindowsManifest/*.inc']), copts=llvm_copts)
cc_library(name='X86AsmParser', deps=[':config', ':MC', ':MCParser', ':Support', ':X86Desc', ':X86Info'], srcs=glob(['lib/Target/X86/AsmParser/*.c', 'lib/Target/X86/AsmParser/*.cpp', 'lib/Target/X86/AsmParser/*.inc']), hdrs=glob(['include/llvm/Target/X86/AsmParser/*.h', 'include/llvm/Target/X86/AsmParser/*.def', 'include/llvm/Target/X86/AsmParser/*.inc', 'lib/Target/X86/AsmParser/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/X86'])
cc_library(name='X86CodeGen', deps=[':config', ':Analysis', ':AsmPrinter', ':CodeGen', ':Core', ':MC', ':SelectionDAG', ':Support', ':Target', ':X86Desc', ':X86Info', ':GlobalISel', ':ProfileData', ':CFGuard', ':x86_defs'], srcs=glob(['lib/Target/X86/*.c', 'lib/Target/X86/*.cpp', 'lib/Target/X86/*.inc']), hdrs=glob(['include/llvm/Target/X86/*.h', 'include/llvm/Target/X86/*.def', 'include/llvm/Target/X86/*.inc', 'lib/Target/X86/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/X86'])
cc_library(name='X86Desc', deps=[':config', ':MC', ':MCDisassembler', ':Support', ':X86Info', ':BinaryFormat'], srcs=glob(['lib/Target/X86/MCTargetDesc/*.c', 'lib/Target/X86/MCTargetDesc/*.cpp', 'lib/Target/X86/MCTargetDesc/*.inc']), hdrs=glob(['include/llvm/Target/X86/MCTargetDesc/*.h', 'include/llvm/Target/X86/MCTargetDesc/*.def', 'include/llvm/Target/X86/MCTargetDesc/*.inc', 'lib/Target/X86/MCTargetDesc/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/X86'])
cc_library(name='X86Disassembler', deps=[':config', ':MCDisassembler', ':Support', ':X86Info'], srcs=glob(['lib/Target/X86/Disassembler/*.c', 'lib/Target/X86/Disassembler/*.cpp', 'lib/Target/X86/Disassembler/*.inc']), hdrs=glob(['include/llvm/Target/X86/Disassembler/*.h', 'include/llvm/Target/X86/Disassembler/*.def', 'include/llvm/Target/X86/Disassembler/*.inc', 'lib/Target/X86/Disassembler/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/X86'])
cc_library(name='X86Info', deps=[':config', ':Support', ':MC', ':X86CommonTableGen'], srcs=glob(['lib/Target/X86/TargetInfo/*.c', 'lib/Target/X86/TargetInfo/*.cpp', 'lib/Target/X86/TargetInfo/*.inc', 'lib/Target/X86/MCTargetDesc/*.h']), hdrs=glob(['include/llvm/Target/X86/TargetInfo/*.h', 'include/llvm/Target/X86/TargetInfo/*.def', 'include/llvm/Target/X86/TargetInfo/*.inc', 'lib/Target/X86/TargetInfo/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/X86'])
cc_library(name='XCoreCodeGen', deps=[':config', ':Analysis', ':AsmPrinter', ':CodeGen', ':Core', ':MC', ':SelectionDAG', ':Support', ':Target', ':TransformUtils', ':XCoreDesc', ':XCoreInfo'], srcs=glob(['lib/Target/XCore/*.c', 'lib/Target/XCore/*.cpp', 'lib/Target/XCore/*.inc']), hdrs=glob(['include/llvm/Target/XCore/*.h', 'include/llvm/Target/XCore/*.def', 'include/llvm/Target/XCore/*.inc', 'lib/Target/XCore/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/XCore'])
cc_library(name='XCoreDesc', deps=[':config', ':MC', ':Support', ':XCoreInfo'], srcs=glob(['lib/Target/XCore/MCTargetDesc/*.c', 'lib/Target/XCore/MCTargetDesc/*.cpp', 'lib/Target/XCore/MCTargetDesc/*.inc']), hdrs=glob(['include/llvm/Target/XCore/MCTargetDesc/*.h', 'include/llvm/Target/XCore/MCTargetDesc/*.def', 'include/llvm/Target/XCore/MCTargetDesc/*.inc', 'lib/Target/XCore/MCTargetDesc/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/XCore'])
cc_library(name='XCoreDisassembler', deps=[':config', ':MCDisassembler', ':Support', ':XCoreInfo'], srcs=glob(['lib/Target/XCore/Disassembler/*.c', 'lib/Target/XCore/Disassembler/*.cpp', 'lib/Target/XCore/Disassembler/*.inc']), hdrs=glob(['include/llvm/Target/XCore/Disassembler/*.h', 'include/llvm/Target/XCore/Disassembler/*.def', 'include/llvm/Target/XCore/Disassembler/*.inc', 'lib/Target/XCore/Disassembler/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/XCore'])
cc_library(name='XCoreInfo', deps=[':config', ':Support'], srcs=glob(['lib/Target/XCore/TargetInfo/*.c', 'lib/Target/XCore/TargetInfo/*.cpp', 'lib/Target/XCore/TargetInfo/*.inc']), hdrs=glob(['include/llvm/Target/XCore/TargetInfo/*.h', 'include/llvm/Target/XCore/TargetInfo/*.def', 'include/llvm/Target/XCore/TargetInfo/*.inc', 'lib/Target/XCore/TargetInfo/*.h']), copts=llvm_copts + ['-Iexternal/llvm-project/llvm/lib/Target/XCore'])
cc_library(name='XRay', deps=[':config', ':Support', ':Object'], srcs=glob(['lib/XRay/*.c', 'lib/XRay/*.cpp', 'lib/XRay/*.inc', 'lib/XRay/*.h']), hdrs=glob(['include/llvm/XRay/*.h', 'include/llvm/XRay/*.def', 'include/llvm/XRay/*.inc']), copts=llvm_copts)
cc_library(name='gtest', deps=[':config', ':Support'], srcs=glob(['utils/unittest/*.c', 'utils/unittest/*.cpp', 'utils/unittest/*.inc', 'utils/unittest/*.h']), hdrs=glob(['utils/unittest/*.h', 'utils/unittest/*.def', 'utils/unittest/*.inc']), copts=llvm_copts)
cc_library(name='gtest_main', deps=[':config', ':gtest'], srcs=glob(['utils/unittest/*.c', 'utils/unittest/*.cpp', 'utils/unittest/*.inc', 'utils/unittest/*.h']), hdrs=glob(['utils/unittest/*.h', 'utils/unittest/*.def', 'utils/unittest/*.inc']), copts=llvm_copts)
