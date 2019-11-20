#!/usr/local/bin/perl
#
# Filename: findingFiles.pl
# Description: search for a file in all subdirectories
# Developer: Nicolas CHEN


print "Enter the current directory path: ";
my $dir = <STDIN>;
print "Enter searched file: ";
my $filename = <STDIN>;

chomp($dir); #It removes characters at the end of strings.
chomp($filename);

search_dir ($dir);


sub search_dir {
    my ($dir) = @_;
    my $dh;
    
    if ( !opendir ($dh, $dir)) {
        warn "Unable to open $dir: $!\n";
        return;
    }
    
    readdir ($dh);
    readdir ($dh);
    
    while (my $file = readdir ($dh) ) {
        
        my $path = "$dir\\$file";

        if ( -d $path ) {
            search_dir ($path); 
        }
        else {     
            my @words = split(/\\/, $path);
            if ($words[-1] =~ m/$filename/) {                
                print "File $filename found in $dir \n";
            } 
          
        }
    }
    
    closedir ($dh);
}

