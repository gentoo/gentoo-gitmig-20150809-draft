# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-devel/perl/perl-5.8.0-r2.ebuild,v 1.2 2002/08/16 02:13:17 mcummings Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Larry Wall's Practical Extraction and Reporting Language"
SRC_URI="ftp://ftp.perl.org/pub/CPAN/src/${P}.tar.gz"
HOMEPAGE="http://www.perl.org" 
LICENSE="Artistic GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="sys-apps/groff berkdb? ( >=sys-libs/db-3.2.3h-r3 =sys-libs/db-1.85-r1 ) gdbm? ( >=sys-libs/gdbm-1.8.0 )"

RDEPEND="berkdb? ( >=sys-libs/db-3.2.3h-r3 =sys-libs/db-1.85-r1 ) gdbm? ( >=sys-libs/gdbm-1.8.0 )"
    
src_compile() {
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

	cd ${S}

	rm -f config.sh Policy.sh

	sh Configure -des \
		-Darchname=${CHOST%%-*}-linux \
		-Dcc=gcc \
		-Dcccdlflags='-fPIC' \
		-Dccdlflags='-rdynamic' \
		-Dprefix=/usr \
		-Dlocincpth=' ' \
		-Doptimize="${CFLAGS}" \
		-Duselargefiles \
		-Duseshrplib \
		-Dlibperl=libperl.so \
		-Dd_dosuid \
		-Dd_semctl_semun \
		-Dusethreads \
		${myconf} || die

	make -f Makefile depend || die "Couldn't make libperl.so depends"
	make -f Makefile libperl.so || die "Unable to make libperl.so" 
	mv libperl.so ${WORKDIR}


	cd ${WORKDIR}
	rm -rf ${S}
	unpack ${A}
	cd ${S}
				

	cat > config.over <<EOF
installprefix=${D}/usr
installarchlib=\`echo \$installarchlib | sed "s!\$prefix!\$installprefix!"\`
installbin=\`echo \$installbin | sed "s!\$prefix!\$installprefix!"\`
installman1dir=\`echo \$installman1dir | sed "s!\$prefix!\$installprefix!"\`
installman3dir=\`echo \$installman3dir | sed "s!\$prefix!\$installprefix!"\`
installman1dir=`echo $installman1dir | sed "s!/share/share/!/share/!"`
installman3dir=`echo $installman3dir | sed "s!/share/share/!/share/!"`
installman1dir=\`echo \$installman1dir | sed "s!/usr/man/!/usr/share/man/!"\`
installman3dir=\`echo \$installman3dir | sed "s!/usr/man/!/usr/share/man/!"\`
man1ext=1
man3ext=3pm
installprivlib=\`echo \$installprivlib | sed "s!\$prefix!\$installprefix!"\`
installscript=\`echo \$installscript | sed "s!\$prefix!\$installprefix!"\`
installsitelib=\`echo \$installsitelib | sed "s!\$prefix!\$installprefix!"\`
installsitearch=\`echo \$installsitearch | sed "s!\$prefix!\$installprefix!"\`
EOF
	sh Configure -des \
		-Darchname=${CHOST%%-*}-linux \
		-Dcc=gcc \
		-Dprefix=/usr \
		-Dlocincpth=' ' \
		-Doptimize="${CFLAGS}" \
		-Duselargefiles \
		-Dd_dosuid \
		-Dd_semctl_semun \
		-Dusethreads \
		${myconf} || die "Unable to configure"
	emake || die "Unable to make"

	export PARCH=`grep myarchname config.sh | cut -f2 -d"'"`

	if [ `expr "$PARCH" ":" "sparc"` -gt 4 ]; then
	  echo "Skipping tests on this platform"
	else
	  make test
	fi
							

}

src_install () {
	
	cd ${S}
	
	export PARCH=`grep myarchname config.sh | cut -f2 -d"'"`
	
	insinto /usr/lib/perl5/${PV}/${PARCH}-thread-multi/CORE/
	doins ${WORKDIR}/libperl.so
	dosym /usr/lib/perl5/${PV}/${PARCH}-thread-multi/CORE/libperl.so /usr/lib/libperl.so
	#Fix for "stupid" modules and programs
	dosym /usr/lib/perl5/${PV}/${PARCH}-thread-multi /usr/lib/perl5/${PV}/${PARCH}	
	dodir /usr/lib/perl5/site_perl/${PV}/${PARCH}-thread-multi
	dosym /usr/lib/perl5/site_perl/${PV}/${PARCH}-thread-multi /usr/lib/perl5/site_perl/${PV}/${PARCH}	

	#This is to fix a missing c flag for backwards compat
	make DESTDIR=${D} INSTALLMAN1DIR=${D}/usr/share/man/man1 INSTALLMAN3DIR=${D}/usr/share/man/man3 install || die "Unable to make install"

	cp ${D}/usr/lib/perl5/${PV}/${PARCH}-thread-multi/Config.pm ${D}/usr/lib/perl5/${PV}/${PARCH}-thread-multi/Config.pm.bak
	sed -e "s:ccflags=':ccflags='-DPERL5 :" ${D}/usr/lib/perl5/${PV}/${PARCH}-thread-multi/Config.pm.bak > ${D}/usr/lib/perl5/${PV}/${PARCH}-thread-multi/Config.pm
	cp ${D}/usr/lib/perl5/${PV}/${PARCH}-thread-multi/Config.pm ${D}/usr/lib/perl5/${PV}/${PARCH}-thread-multi/Config.pm.bak
	sed -e "s:cppflags=':cppflags='-DPERL5 :" ${D}/usr/lib/perl5/${PV}/${PARCH}-thread-multi/Config.pm.bak > ${D}/usr/lib/perl5/${PV}/${PARCH}-thread-multi/Config.pm
	rm -f ${D}/usr/lib/perl5/${PV}/${PARCH}-thread-multi/Config.pm.bak

	 ./perl installman --man1dir=${D}/usr/share/man/man1 --man1ext=1 --man3dir=${D}/usr/share/man/man3 --man3ext=3

# This removes ${D} from Config.pm

	dosed /usr/lib/perl5/${PV}/${CHOST%%-*}-linux-thread-multi/Config.pm
	dosed /usr/lib/perl5/${PV}/${CHOST%%-*}-linux-thread-multi/.packlist
	 

	dodoc Changes* Artistic Copying README Todo* AUTHORS
	prepalldocs

# HTML Documentation
# We expect errors, warnings, and such with the following. We do it twice per
# the installation directions for 5.8

	dodir /usr/share/doc/${PF}/html
	./perl installhtml \
	--podroot=.                 \
	--podpath=lib:ext:pod:vms   \
	--recurse \
	--htmldir=${D}/usr/share/doc/${PF}/html \
	--libpods=perlfunc:perlguts:perlvar:perlrun:perlop

}

