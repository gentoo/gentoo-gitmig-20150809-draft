# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-devel/perl/perl-5.6.1-r2.ebuild,v 1.1 2002/01/31 01:46:35 gbevin Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Larry Wall's Practical Extraction and Reporting Language"
SRC_URI="ftp://ftp.perl.org/pub/perl/CPAN/src/${P}.tar.gz"
HOMEPAGE="http://www.perl.org"

DEPEND="virtual/glibc sys-apps/groff berkdb? ( >=sys-libs/db-3.2.3h-r3 =sys-libs/db-1.85-r1 ) gdbm? ( >=sys-libs/gdbm-1.8.0 )"

RDEPEND="virtual/glibc berkdb? ( >=sys-libs/db-3.2.3h-r3 =sys-libs/db-1.85-r1 ) gdbm? ( >=sys-libs/gdbm-1.8.0 )"

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

	# configure for libperl.so
    sh Configure -des \
		-Darchname=${CHOST%%-*}-linux \
		-Dcccdlflags='-fPIC' \
		-Dccdlflags='-rdynamic' \
		-Dprefix=/usr \
		-Doptimize="${CFLAGS}" \
		-Duselargefiles \
		-Duseshrplib \
		-Dlibperl=libperl.so \
		-Dd_dosuid \
		-Dd_semctl_semun \
		${myconf} || die
	mv -f Makefile Makefile_orig
	sed -e 's#^CCDLFLAGS = -rdynamic -Wl,-rpath,/usr/lib/perl5/.*#CCDLFLAGS = -rdynamic#' \
		Makefile_orig > Makefile
    export PARCH=`grep myarchname config.sh | cut -f2 -d"'"`
	make libperl.so || die
	mv libperl.so ${WORKDIR}

	# configure for libperl.a
	make distclean	
    sh Configure -des \
		-Darchname=${CHOST%%-*}-linux \
		-Dcccdlflags='-fPIC' \
		-Dccdlflags='-rdynamic' \
		-Dprefix=/usr \
		-Doptimize="${CFLAGS}" \
		-Duselargefiles \
		-Dd_dosuid \
		-Dd_semctl_semun \
		${myconf} || die
	mv -f Makefile Makefile_orig
	sed -e 's#^CCDLFLAGS = -rdynamic -Wl,-rpath,/usr/lib/perl5/.*#CCDLFLAGS = -rdynamic#' \
		Makefile_orig > Makefile
    export PARCH=`grep myarchname config.sh | cut -f2 -d"'"`
	#for some reason, this rm -f doesn't seem to actually do anything.  So we explicitly use "Makefile"
	#(rather than the default "makefile") in all make commands below.
	rm -f makefile x2p/makefile
    make -f Makefile || die

    make -f Makefile test || die
}

src_install() {

	insinto /usr/lib/perl5/${PV}/i686-linux/CORE/
	doins ${WORKDIR}/libperl.so 
	
    export PARCH=`grep myarchname config.sh | cut -f2 -d"'"`

    make -f Makefile INSTALLMAN1DIR=${D}/usr/share/man/man1 INSTALLMAN3DIR=${D}/usr/share/man/man3 install || die
    install -m 755 utils/pl2pm ${D}/usr/bin/pl2pm

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
