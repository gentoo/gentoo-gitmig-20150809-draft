# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/perl/perl-5.6.1-r12.ebuild,v 1.9 2004/01/18 06:46:58 rac Exp $

DESCRIPTION="Larry Wall's Practical Extraction and Reporting Language"
MM_VERSION="6.05"
SAFE_VERSION="2.09"
SRC_URI="ftp://ftp.perl.org/pub/CPAN/src/${P}.tar.gz
	ftp://ftp.perl.org/pub/CPAN/modules/by-module/ExtUtils/ExtUtils-MakeMaker-${MM_VERSION}.tar.gz
	ftp://ftp.perl.org/pub/CPAN/modules/by-module/Safe/Safe-${SAFE_VERSION}.tar.gz"
HOMEPAGE="http://www.perl.org/"

LICENSE="Artistic GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~alpha ~mips ~hppa"
IUSE="berkdb gdbm"

RDEPEND="gdbm? ( >=sys-libs/gdbm-1.8.0 )
	>=sys-libs/db-3.2.3h-r3
	=sys-libs/db-1.85-r1"
DEPEND="sys-apps/groff
	>=sys-apps/portage-2.0.45-r5
	>=sys-apps/sed-4
	${RDEPEND}"

src_unpack() {
	unpack ${A}

	# replace some modules with newer ones from CPAN.

	einfo "Replacing core ExtUtils::MakeMaker with newer version ${MM_VERSION}"
	chmod +w ${S}/lib/ExtUtils/*
	cp -R ${WORKDIR}/ExtUtils-MakeMaker-${MM_VERSION}/lib/ExtUtils/* ${S}/lib/ExtUtils/
	einfo "Replacing core Safe.pm with newer version ${SAFE_VERSION}"
	chmod +w ${S}/ext/Opcode/Safe.pm
	cp ${WORKDIR}/Safe-${SAFE_VERSION}/Safe.pm ${S}/ext/Opcode/

	# when using a newish MakeMaker, we must make sure PERL_CORE is
	# set to 1 when building extensions in the core.  failure to
	# do so will result in things like DynaLoader.a languishing in
	# blib directories, and not being useful.

	sed -ie "s/INSTALLDIRS=perl/INSTALLDIRS=perl PERL_CORE=1/" ${S}/ext/util/make_ext || die "make_ext patch failed"
}

src_compile() {
	use gdbm || use berkdb || die "You must have either gdbm or berkdb installed and in your use flags."

	#The following is to handle international users. Perl does nls post-install
	export LC_ALL=C

	if [ "${ARCH}" = "alpha" ]; then
		CFLAGS="${CFLAGS} -fPIC"
		CXXFLAGS="${CXXFLAGS} -fPIC"
	fi

	local myconf
	if [ "`use gdbm`" ]
	then
		myconf="-Di_gdbm"
	fi

	# It seems that perl config use the hostname instead of the osname on hppa
	if [ "`use hppa`" ]
	then
		myconf="${myconf} -Dosname=linux"
	fi

	if [ "`use berkdb`" ]
	then
		myconf="${myconf} -Di_db -Di_ndbm"
	else
		myconf="${myconf} -Ui_db -Ui_ndbm"
	fi

	# put in built-in removal patch
	patch -p1 < ${FILESDIR}/${PV}-builtin-fixup.diff || die
	patch -p0 < ${FILESDIR}/${PV}-op-test-fix.diff || die

	# configure for libperl.so
	sh Configure -des \
		-Darchname=${CHOST%%-*}-linux \
		-Dcccdlflags='-fPIC' \
		-Dcc=gcc \
		-Dccdlflags='-rdynamic' \
		-Dprefix='/usr' \
		-Dvendorprefix='/usr' \
		-Dsiteprefixx='/usr' \
		-Dlocincpth=' ' \
		-Doptimize="${CFLAGS}" \
		-Duselargefiles \
		-Duseshrplib \
		-Dman3ext=3pm \
		-Dlibperl=libperl.so \
		-Dd_dosuid \
		-Dd_semctl_semun \
		-Dcf_by=Gentoo \
		-Ud_csh \
		${myconf} || die
	# add optimization flags
	cp config.sh config.sh.orig
	sed -e "s:optimize='-O2':optimize=\'${CFLAGS}\':" config.sh.orig > config.sh
	# create libperl.so and move it out of the way
	mv -f Makefile Makefile_orig
	sed -e 's#^CCDLFLAGS = -rdynamic -Wl,-rpath,/usr/lib/perl5/.*#CCDLFLAGS = -rdynamic#' \
	    -e 's#^all: $(FIRSTMAKEFILE) #all: README #' \
		Makefile_orig > Makefile
	export PARCH=`grep myarchname config.sh | cut -f2 -d"'"`

	make -f Makefile depend || die
	make -f Makefile libperl.so || die
	mv libperl.so ${WORKDIR}

	# starting from scratch again
	cd ${WORKDIR}
	rm -rf ${S}
	src_unpack
	cd ${S}

	# put in built-in removal patch
	patch -p1 < ${FILESDIR}/${PV}-builtin-fixup.diff || die
	patch -p0 < ${FILESDIR}/${PV}-op-test-fix.diff || die

	# configure for libperl.a
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

	sh Configure -des \
		-Dcc=gcc \
		-Dprefix='/usr' \
		-Dvendorprefix='/usr' \
		-Dsiteprefixx='/usr' \
		-Darchname=${CHOST%%-*}-linux \
		-Doptimize="${CFLAGS}" \
		-Duselargefiles \
		-Dd_dosuid \
		-Dlocincpth=' ' \
		-Dd_semctl_semun \
		-Dman3ext=3pm \
		-Dcf_by=Gentoo \
		-Ud_csh \
		${myconf} || die

	#Optimize ;)
	cp config.sh config.sh.orig
	sed -e "s:optimize='-O2':optimize=\'${CFLAGS}\':" config.sh.orig > config.sh
	#THIS IS USED LATER:
	export PARCH=`grep myarchname config.sh | cut -f2 -d"'"`

# Umm, for some reason this doesn't want to work, so we'll just remove
#  the makefiles and let make rebuild them itself. (It seems to do it
#  right the second time... -- pete
#    cp makefile makefile.orig
#    sed -e "s:^0::" makefile.orig > makefile

	mv Makefile Makefile_orig
	sed -e 's#^all: $(FIRSTMAKEFILE) #all: README #' \
		Makefile_orig > Makefile

	make || die

	# Parallel make fails
	# dont use the || die since some tests fail on bootstrap
	if [ `expr "$PARCH" ":" "sparc"` -gt 4 ]; then
		echo "Skipping tests on this platform"
	else
	    make test
	fi
}

src_install() {
#The following is to handle international users. Perl does nls post-install
	export LC_ALL=C

	export PARCH=`grep myarchname config.sh | cut -f2 -d"'"`

	insinto /usr/lib/perl5/${PV}/${PARCH}/CORE/
	doins ${WORKDIR}/libperl.so
	dosym /usr/lib/perl5/${PV}/${PARCH}/CORE/libperl.so /usr/lib/libperl.so


#    make -f Makefile \
#		INSTALLMAN1DIR=${D}/usr/share/man/man1 \
#		INSTALLMAN3DIR=${D}/usr/share/man/man3 \
#		install || die

	make \
		DESTDIR=${D} \
		INSTALLMAN1DIR=${D}/usr/share/man/man1 \
		INSTALLMAN3DIR=${D}/usr/share/man/man3 \
		install || die "Unable to make install"
	install -m 755 utils/pl2pm ${D}/usr/bin/pl2pm

	#man pages

#	./perl installman \
#		--man1dir=${D}/usr/share/man/man1 \
#		--man1ext=1 \
#		--man3dir=${D}/usr/share/man/man3 \
#		--man3ext=3


	# This removes ${D} from Config.pm

	dosed /usr/lib/perl5/${PV}/${CHOST%%-*}-linux/Config.pm
	dosed /usr/lib/perl5/${PV}/${CHOST%%-*}-linux/.packlist

	# DOCUMENTATION

	dodoc Changes* Artistic Copying README Todo* AUTHORS
	prepalldocs


	# HTML Documentation
	dodir /usr/share/doc/${PF}/html
	${D}/usr/bin/perl installhtml --recurse --htmldir=${D}/usr/share/doc/${PF}/html

}


pkg_postinst() {
	# generates the ph files for perl
	cd /usr/include; h2ph -r -l .

}
