# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-devel/perl/perl-5.6.0-r1.ebuild,v 1.8 2000/10/28 19:55:53 achim Exp $

P=perl-5.6.0
A=${P}.tar.gz
S=${WORKDIR}/perl-5.6.0
DESCRIPTION="Larry Wall's Practical Extraction and Reporting Language"
SRC_URI="ftp://ftp.perl.org/pub/perl/CPAN/src/${A}"
HOMEPAGE="http://www.perl.org"

src_compile() {   
                        
# this is gross -- from Christian Gafton, Red Hat
cat > config.over <<EOF
installprefix=${D}/usr
test -d \$installprefix || mkdir \$installprefix
test -d \$installprefix/bin || mkdir \$installprefix/bin
installarchlib=\`echo \$installarchlib | sed "s!\$prefix!\$installprefix!"\`
installbin=\`echo \$installbin | sed "s!\$prefix!\$installprefix!"\`
installman1dir=\`echo \$installman1dir | sed "s!\$prefix!\$installprefix!"\`
installman3dir=\`echo \$installman3dir | sed "s!\$prefix!\$installprefix!"\`
installprivlib=\`echo \$installprivlib | sed "s!\$prefix!\$installprefix!"\`
installscript=\`echo \$installscript | sed "s!\$prefix!\$installprefix!"\`
installsitelib=\`echo \$installsitelib | sed "s!\$prefix!\$installprefix!"\`
installsitearch=\`echo \$installsitearch | sed "s!\$prefix!\$installprefix!"\`
EOF

#    cp Configure Configure.orig
#    sed -e "12339d" Configure.orig > Configure
#    sh Configure -d

    sh Configure -des -Dprefix=/usr -Dd_dosuid \
	-Dd_semctl_semun -Di_db -Di_gdbm \
	-Dusethreads -Duse505threads
	-Dman3dir=/usr/man/man3

    #Optimize ;)
    cp config.sh config.sh.orig
    sed -e "s/optimize='-O2'/optimize=\'${CFLAGS}\'/" config.sh.orig > config.sh
    #THIS IS USED LATER:
    export PARCH=`grep myarchname config.sh | cut -f2 -d"'"`
    try make
    make test
}

src_install() {                               
    try make install
    install -m 755 utils/pl2pm $D/usr/bin/pl2pm
export D
# Generate *.ph files with a trick. Is this sick or what?
# Yes it is, and thank you Christian for getting sick just so we can
# run perl :)

make all -f - <<EOF
STDH    =\$(wildcard /usr/include/linux/*.h) \$(wildcard /usr/include/asm/*.h) \
          \$(wildcard /usr/include/scsi/*.h)
GCCDIR  = \$(shell gcc --print-file-name include)

PERLLIB = \$(D)/usr/lib/perl5/%{perlver}%{perlrel}
PERL    = PERL5LIB=\$(PERLLIB) \$(D)/usr/bin/perl
PHDIR   = \$(PERLLIB)/\${PARCH}-linux
H2PH    = \$(PERL) \$(D)/usr/bin/h2ph -d \$(PHDIR)/

all: std-headers gcc-headers fix-config

std-headers: \$(STDH)
        cd /usr/include && \$(H2PH) \$(STDH:/usr/include/%%=%%)

gcc-headers: \$(GCCH)
        cd \$(GCCDIR) && \$(H2PH) \$(GCCH:\$(GCCDIR)/%%=%%)

fix-config: \$(PHDIR)/Config.pm
        \$(PERL) -i -p -e "s|\$(D)||g;" \$<

EOF

#MainDir=$(pwd)
#cd modules
#for module in * ; do 
#    eval $($MainDir/perl '-V:installarchlib')
#    mkdir -p $D/$installarchlib
#    try make -C $module install PREFIX=$D/usr \
#        INSTALLMAN3DIR=$D/usr/man/man3
#done
#cd $MainDir


#man pages
    
    ./perl installman --man1dir=${D}/usr/man/man1 --man1ext=1 --man3dir=${D}/usr/man/man3 --man3ext=3
    prepman

# DOCUMENTATION

    dodoc Changes* Artistic Copying README



}




