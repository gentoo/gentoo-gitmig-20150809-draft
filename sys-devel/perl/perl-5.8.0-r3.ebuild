# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-devel/perl/perl-5.8.0-r3.ebuild,v 1.1 2002/09/14 03:16:15 mcummings Exp $

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
	if [ "`use sparc`" ]
	then
	 myconf="${myconf} -Ud_longdbl"
	fi
	if [ "`use sparc64`" ]
	then
	 myconf="${myconf} -Ud_longdbl"
	fi
	
	cd ${S}

	rm -f config.sh Policy.sh

	sh Configure -des \
		-Darchname=${CHOST%%-*}-linux \
		-Dcccdlflags='-fPIC' \
		-Dccdlflags='-rdynamic' \
		-Dprefix=/usr \
		-Dlocincpth=' ' \
		-Doptimize="${CFLAGS}" \
		-Duselargefiles \
		-Duseshrplib \
		-Dman3ext=3pm \
		-Dlibperl=libperl.so \
		-Dd_dosuid \
		-Dd_semctl_semun \
		-Dusethreads \
		-Dcf_by=Gentoo \
		-Ud_csh \
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
		-Dprefix=/usr \
		-Dlocincpth=' ' \
		-Doptimize="${CFLAGS}" \
		-Duselargefiles \
		-Dd_dosuid \
		-Dd_semctl_semun \
		-Dman3ext=3pm \
		-Dcf_by=Gentoo \
		-Dusethreads \
		-Ud_csh \
		${myconf} || die "Unable to configure"
	emake || die "Unable toe make"
#	make || die "Unable to make"
	
	make -i test CCDFLAGS=
							

}

src_install () {
	
	cd ${S}
	
	insinto /usr/lib/perl5/${PV}/${CHOST%%-*}-linux-thread-multi/CORE/
	doins ${WORKDIR}/libperl.so
	dosym /usr/lib/perl5/${PV}/${CHOST%%-*}-linux-thread-multi/CORE/libperl.so /usr/lib/libperl.so
	#Fix for "stupid" modules and programs
	dosym /usr/lib/perl5/${PV}/${CHOST%%-*}-linux-thread-multi /usr/lib/perl5/${PV}/${CHOST%%-*}-linux
	dodir /usr/lib/perl5/site_perl/${PV}/${CHOST%%-*}-linux-thread-multi
	dosym /usr/lib/perl5/site_perl/${PV}/${CHOST%%-*}-linux-thread-multi /usr/lib/perl5/site_perl/${PV}/${CHOST%%-*}-linux


	make DESTDIR=${D} INSTALLMAN1DIR=${D}/usr/share/man/man1 INSTALLMAN3DIR=${D}/usr/share/man/man3 install || die "Unable to make install"

	cp -f utils/h2ph utils/h2ph_patched
	patch -p1 < ${FILESDIR}/perl-5.8.0-RC2-special-h2ph-not-failing-on-machine_ansi_header.patch
	
	LD_LIBRARY_PATH=. ./perl -Ilib utils/h2ph_patched -a -d ${D}/usr/lib/perl5/${PV}/${CHOST%%-*}-linux-thread-multi <<EOF
asm/termios.h
syscall.h
syslimits.h
syslog.h
sys/ioctl.h
sys/socket.h
sys/time.h
wait.h
EOF

	#This is to fix a missing c flag for backwards compat
	

	cp ${D}/usr/lib/perl5/${PV}/${CHOST%%-*}-linux-thread-multi/Config.pm ${D}/usr/lib/perl5/${PV}/${CHOST%%-*}-linux-thread-multi/Config.pm.bak
	sed -e "s:ccflags=':ccflags='-DPERL5 :" ${D}/usr/lib/perl5/${PV}/${CHOST%%-*}-linux-thread-multi/Config.pm.bak > ${D}/usr/lib/perl5/${PV}/${CHOST%%-*}-linux-thread-multi/Config.pm
	cp ${D}/usr/lib/perl5/${PV}/${CHOST%%-*}-linux-thread-multi/Config.pm ${D}/usr/lib/perl5/${PV}/${CHOST%%-*}-linux-thread-multi/Config.pm.bak
	sed -e "s:cppflags=':cppflags='-DPERL5 :" ${D}/usr/lib/perl5/${PV}/${CHOST%%-*}-linux-thread-multi/Config.pm.bak > ${D}/usr/lib/perl5/${PV}/${CHOST%%-*}-linux-thread-multi/Config.pm

	rm -f ${D}/usr/lib/perl5/${PV}/${CHOST%%-*}-linux-thread-multi/Config.pm.bak
	rm -f ${D}/usr/lib/perl5/${PV}/Config.pm.4install


# A poor fix for the miniperl issues
	sed -e 's:./miniperl:/usr/bin/perl:' ${D}/usr/lib/perl5/${PV}/ExtUtils/xsubpp > ${D}/usr/lib/perl5/${PV}/ExtUtils/xsubpp.bak
	mv ${D}/usr/lib/perl5/${PV}/ExtUtils/xsubpp.bak ${D}/usr/lib/perl5/${PV}/ExtUtils/xsubpp
	chmod 444 ${D}/usr/lib/perl5/${PV}/ExtUtils/xsubpp
	sed -e 's:./miniperl:/usr/bin/perl:' ${D}/usr/bin/xsubpp > ${D}/usr/bin/xsubpp.bak
	mv ${D}/usr/bin/xsubpp.bak ${D}/usr/bin/xsubpp
	chmod 755 ${D}/usr/bin/xsubpp


	 ./perl installman --man1dir=${D}/usr/share/man/man1 --man1ext=1 --man3dir=${D}/usr/share/man/man3 --man3ext=3

# This removes ${D} from Config.pm

	dosed /usr/lib/perl5/${PV}/${CHOST%%-*}-linux-thread-multi/Config.pm
	dosed /usr/lib/perl5/${PV}/${CHOST%%-*}-linux-thread-multi/.packlist

	 

	dodoc Changes* Artistic Copying README Todo* AUTHORS
	prepalldocs

# HTML Documentation
# We expect errors, warnings, and such with the following. 

	dodir /usr/share/doc/${PF}/html
	./perl installhtml \
	--podroot=.                 \
	--podpath=lib:ext:pod:vms   \
	--recurse \
	--htmldir=${D}/usr/share/doc/${PF}/html \
	--libpods=perlfunc:perlguts:perlvar:perlrun:perlop

}

