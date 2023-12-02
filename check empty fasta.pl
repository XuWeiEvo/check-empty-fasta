#!/usr/bin/perl

use strict;
use warnings;


# ���������ļ���
my $input_folder = './';
my $output_folder = './';

# ���������ļ����е�����FASTA�ļ�
opendir(my $dh, $input_folder) or die "�޷��������ļ���: $!";
while (my $file = readdir $dh) {
    next if $file =~ /^\./;  # ���������ļ����ļ���

    my $input_file = "$input_folder/$file";
    my $output_file = "$output_folder/$file.txt";


# �����������ļ�
open(my $input_fh, '<', $input_file) or die "�޷��������ļ�: $!";
open(my $output_fh, '>', $output_file) or die "�޷�������ļ�: $!";

# ���ж�ȡ�����ļ�
while (my $line = <$input_fh>) {
    chomp $line;

    if ($line =~ /^>/) {
        # �������">"��ͷ��˵�������б�ʶ��
        my $sequence_id = $line;

        # ��ȡ��һ����Ϊ����
        my $sequence = <$input_fh>;
        chomp $sequence;

        # �ж������Ƿ�Ϊ������
        if ($sequence =~ /^-+$/) {
            # ��������е��ļ�
            print $output_fh "$sequence_id\n$sequence\n";
        }
    }
}

# �ر��ļ����
close($input_fh);
close($output_fh);

print "����������ȡ��$output_file�ļ��С�\n";}

closedir $dh;