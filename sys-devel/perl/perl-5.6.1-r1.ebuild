# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-devel/perl/perl-5.6.1-r1.ebuild,v 1.2 2001/07/30 20:21:34 pete Exp $


A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Larry Wall's Practical Extraction and Reporting Language"
SRC_URI="ftp://ftp.perl.org/pub/perl/CPAN/src/${A}"
HOMEPAGE="http://www.perl.org"

DEPEND="virtual/glibc sys-apps/groff
        berkdb? ( >=sys-libs/db-3.2.3h-r3
                  =sys-libs/db-1.85-r1 )
	gdbm?   ( >=sys-libs/gdbm-1.8.0 )"

RDEPEND="virtual/glibc
        berkdb? ( >=sys-libs/db-3.2.3h-r3 =sys-libs/db-1.85-r1 )
	gdbm?   ( >=sys-libs/gdbm-1.8.0 )"

src_compile() {

# this is gross -- from Christian Gafton, Red Hat
cat > config.over <<EOF
installprefix=${D}/usr
#test -d \$installprefix || mkdir \$installprefix
#test -d \$installprefix/bin || mkdir \$installprefix/bin
installarchlib=\`echo \$installarchlib | sed "s!\$prefix!\$installprefix!"\`
installbin=\`echo \$installbin | sed "s!\$prefix!\$installprefix!"\`
#installman1dir=\$installprefix/share/man/man1
#installman3dir=\$installprefix/share/man/man3
installman1dir=\`echo \$installman1dir | sed "s!\$prefix!\$installprefix!"\`
installman3dir=\`echo \$installman3dir | sed "s!\$prefix!\$installprefix!"\`
installman1dir=\`echo \$installman1dir | sed "s!/man/!/share/man/!"\`
installman3dir=\`echo \$installman3dir | sed "s!/man/!/share/man/!"\`
man1ext=1
man3ext=3pm
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
 #   if [ "`use perl`" ]
 #   then
 #     # We create a shared libperl only if the use variable perl
 #     # is set, because using a shared lib leads to as significiant
 #     # performance penalty
 #     myconf="${myconf} -Duseshrplib"
 #   fi
    sh Configure -des -Dprefix=/usr -Dd_dosuid \
	-Dd_semctl_semun ${myconf} -Duselargefiles \
	-Darchname=${CHOST%%-*}-linux
	#-Dusethreads -Duse505threads \

    #Optimize ;)
    cp config.sh config.sh.orig
    sed -e "s/optimize='-O2'/optimize=\'${CFLAGS}\'/" config.sh.orig > config.sh
    #THIS IS USED LATER:
    export PARCH=`grep myarchname config.sh | cut -f2 -d"'"`

# Umm, for some reason this doesn't want to work, so we'll just remove
#  the makefiles and let make rebuild them itself. (It seems to do it
#  right the second time... -- pete
#    cp makefile makefile.orig
#    sed -e "s:^0::" makefile.orig > makefile
    rm -f makefile x2p/makefile
    try make
    # Parallel make failes
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

  dosed /usr/lib/perl5/${PV}/${CHOST%%-*}-linux/Config.pm
  dosed /usr/lib/perl5/${PV}/${CHOST%%-*}-linux/.packlist

# DOCUMENTATION

    dodoc Changes* Artistic Copying README Todo* AUTHORS

# HTML Documentation

    dodir /usr/share/doc/${PF}/html
    ./perl installhtml --recurse --htmldir=${D}/usr/share/doc/${PF}/html
    prepalldocs

}
