#!/usr/bin/perl

use strict;
use warnings;


# 输入和输出文件夹
my $input_folder = './';
my $output_folder = './';

# 遍历输入文件夹中的所有FASTA文件
opendir(my $dh, $input_folder) or die "无法打开输入文件夹: $!";
while (my $file = readdir $dh) {
    next if $file =~ /^\./;  # 跳过隐藏文件和文件夹

    my $input_file = "$input_folder/$file";
    my $output_file = "$output_folder/$file.txt";


# 打开输入和输出文件
open(my $input_fh, '<', $input_file) or die "无法打开输入文件: $!";
open(my $output_fh, '>', $output_file) or die "无法打开输出文件: $!";

# 逐行读取输入文件
while (my $line = <$input_fh>) {
    chomp $line;

    if ($line =~ /^>/) {
        # 如果行以">"开头，说明是序列标识行
        my $sequence_id = $line;

        # 读取下一行作为序列
        my $sequence = <$input_fh>;
        chomp $sequence;

        # 判断序列是否为空序列
        if ($sequence =~ /^-+$/) {
            # 输出空序列到文件
            print $output_fh "$sequence_id\n$sequence\n";
        }
    }
}

# 关闭文件句柄
close($input_fh);
close($output_fh);

print "空序列已提取到$output_file文件中。\n";}

closedir $dh;