# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-devel/perl/perl-5.6.0-r6.ebuild,v 1.3 2001/04/09 05:38:55 achim Exp $


A=${P}.tar.gz
S=${WORKDIR}/perl-5.6.0
DESCRIPTION="Larry Wall's Practical Extraction and Reporting Language"
SRC_URI="ftp://ftp.perl.org/pub/perl/CPAN/src/${A}"
HOMEPAGE="http://www.perl.org"

DEPEND="virtual/glibc
        berkdb? ( >=sys-libs/db-3.1.17 )
	gdbm?   ( >=sys-libs/gdbm-1.8.0 )"

src_compile() {

# this is gross -- from Christian Gafton, Red Hat
cat > config.over <<EOF
installprefix=${D}/usr
test -d \$installprefix || mkdir \$installprefix
test -d \$installprefix/bin || mkdir \$installprefix/bin
installarchlib=\`echo \$installarchlib | sed "s!\$prefix!\$installprefix!"\`
installbin=\`echo \$installbin | sed "s!\$prefix!\$installprefix!"\`
installman1dir=\$installprefix/share/man/man1
installman3dir=\$installprefix/share/man/man3
man1ext=1
man3ext=3pl
installprivlib=\`echo \$installprivlib | sed "s!\$prefix!\$installprefix!"\`
installscript=\`echo \$installscript | sed "s!\$prefix!\$installprefix!"\`
installsitelib=\`echo \$installsitelib | sed "s!\$prefix!\$installprefix!"\`
installsitearch=\`echo \$installsitearch | sed "s!\$prefix!\$installprefix!"\`
EOF

    local myconf
    if [ "`use gdbm`" ]
    then
      myconf="-Di_gdbm"
    fi
    if [ "`use berkdb`" ]
    then
      myconf="${myconf} -Di_db -Di_ndbm"
    else
      myconf="${myconf} -Ui_db -Ui_ndbm"
    fi
    sh Configure -des -Dprefix=/usr -Dd_dosuid \
	-Dd_semctl_semun ${myconf} -Duselargefiles \
	-Darchname=${CHOST%%-*}-linux
	#-Dusethreads -Duse505threads \

    #Optimize ;)
    cp config.sh config.sh.orig
    sed -e "s/optimize='-O2'/optimize=\'${CFLAGS}\'/" config.sh.orig > config.sh
    #THIS IS USED LATER:
    export PARCH=`grep myarchname config.sh | cut -f2 -d"'"`
    try make
    # Parallell make failes
    make test
}

src_install() {

    export PARCH=`grep myarchname config.sh | cut -f2 -d"'"`

    try make INSTALLMAN1DIR=${D}/usr/share/man/man1 \
	     INSTALLMAN3DIR=${D}/usr/share/man/man3 install
    install -m 755 utils/pl2pm ${D}/usr/bin/pl2pm

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

#man pages

#    ./perl installman --man1dir=${D}/usr/share/man/man1 --man1ext=1 --man3dir=${D}/usr/share/man/man3 --man3ext=3


# This removes ${D} from Config.pm

  dosed /usr/lib/perl5/5.6.0/${CHOST%%-*}-linux/Config.pm
  dosed /usr/lib/perl5/5.6.0/${CHOST%%-*}-linux/.packlist

# DOCUMENTATION

    dodoc Changes* Artistic Copying README Todo* AUTHORS

# HTML Documentation

    dodir /usr/share/doc/${PF}/html
    ./perl installhtml --recurse --htmldir=${D}/usr/share/doc/${PF}/html
    prepalldocs

}




