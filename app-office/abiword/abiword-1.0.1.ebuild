# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-office/abiword/abiword-1.0.1.ebuild,v 1.4 2002/07/25 19:29:33 aliz Exp $

S=${WORKDIR}/${P}/abi
DESCRIPTION="Text processor"
SRC_URI="http://download.sourceforge.net/abiword/abiword-${PV}.tar.gz"
HOMEPAGE="http://www.abisource.com"
KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"
DEPEND="virtual/x11
	media-libs/libpng
	>=dev-libs/libunicode-0.4-r1
	=x11-libs/gtk+-1.2*
	jpeg?  ( >=media-libs/jpeg-6b-r2 )
	perl?  ( >=sys-devel/perl-5.6 )
	xml2?  ( >=dev-libs/libxml2-2.4.10 )
	spell? ( >=app-text/pspell-ispell-0.12-r1 )
	gnome? ( >=gnome-base/gnome-libs-1.4.1.2-r1
	         >=gnome-extra/gal-0.13-r1 
	         >=gnome-base/bonobo-1.0.9-r1 )"


fix_perl_env() {
	# new configure scripts is a bit broken
	export PERL_ARCHLIB="`(perl -V:installarchlib | sed -e "s/\(.*=\|'\|;\)//g\")`"
	export PERL_LIB="`(perl -V:installprivlib | sed -e "s/\(.*=\|'\|;\)//g\")`"
	export POD2MAN_EXE="`which pod2man`"
	export SITE_LIB="`(perl -V:sitelib | sed -e "s/\(.*=\|'\|;\)//g\")`"
	export SITE_ARCHLIB="`(perl -V:sitearch | sed -e "s/\(.*=\|'\|;\)//g\")`"
}

src_unpack() {

	unpack ${A}

	use perl && ( \
		fix_perl_env

		# Fix perl stuff install outside sandbox, as well as a bug in 
		# Abiword's build system (Abiword.3pm did not install, and
		# the '.packlist' was not generated properly) -- Azarah (25/02/2002).
		cd ${S}/src/bindings/perl
		cp GNUmakefile.am GNUmakefile.am.orig
		sed -e "s:PERL_ARCHLIB = @PERL_ARCHLIB@:PERL_ARCHLIB = ${PERL_ARCHLIB}:" \
			-e "s:PERL_LIB = @PERL_LIB@:PERL_LIB = ${PERL_LIB}:" \
			-e "s:POD2MAN_EXE = @POD2MAN_EXE@:POD2MAN_EXE = ${POD2MAN_EXE}:" \
			-e "s:SITE_LIB = @SITE_LIB@:SITE_LIB = ${SITE_LIB}:" \
			-e "s:SITE_ARCHLIB = @SITE_ARCHLIB@:SITE_ARCHLIB = ${SITE_ARCHLIB}:" \
			-e 's:write $(SITE_ARCHLIB)/auto:write $(PERLDEST)/$(SITE_ARCHLIB)/auto:g' \
			-e 's:blib/lib $(SITE_LIB):blib/lib $(PERLDEST)/$(SITE_LIB):g' \
			-e 's:blib/arch $(SITE_ARCHLIB):blib/arch $(PERLDEST)/$(SITE_ARCHLIB):g' \
			-e 's:blib/bin /usr/bin:blib/bin $(PERLDEST)/usr/bin:g' \
			-e 's:blib/script /usr/bin:blib/script $(PERLDEST)/usr/bin:g' \
			-e 's:blib/man1 /usr/share/man/man1:blib/man1 $(PERLDEST)/usr/share/man/man1:g' \
			-e 's:blib/man3 /usr/share/man/man3:blib/man3 $(PERLDEST)/usr/share/man/man3:g' \
			-e 's:mkpath $(PERL_ARCHLIB):mkpath $(PERLDEST)/$(PERL_ARCHLIB):g' \
			-e 's:$(PERL_ARCHLIB)/perllocal.pod:$(PERLDEST)/$(PERL_ARCHLIB)/perllocal.pod.new:' \
			GNUmakefile.am.orig >GNUmakefile.am || die
		mkdir -p blib/{arch,bin,lib,man1,man3,script}
		cd ${S}
	)

	# clear invalid symlinks
	rm -f ac-helpers/{install-sh,mkinstalldirs,missing}
}

src_compile() {

	local myconf

	use gnome \
		&& myconf="${myconf} --with-gnome --enable-gnome" \
		&& export ABI_OPT_BONOBO=1

	use perl \
		&& myconf="${myconf} --enable-scripting"
	
	use spell \
		&& myconf="${myconf} --with-pspell"

	use xml2 \
		&& myconf="${myconf} --with-libxml2"

	use jpeg \
		&& myconf="${myconf} --with-libjpeg"
	
	use nls \
		&& myconf="${myconf} --enable-bidi"

	./autogen.sh
	
	echo
	echo "*************************************************"
	echo "* Ignore above ERROR as it does not cause build *"
	echo "* to fail.                                      *"
	echo "*************************************************"
	echo

	CFLAGS="${CFLAGS} `gdk-pixbuf-config --cflags`"

	./configure \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--sysconfdir=/etc \
		--localstatedir=/var/lib \
		--enable-extra-optimization \
		${myconf} || die

	# Doesn't work with -j 4 (hallski)
	make UNIX_CAN_BUILD_STATIC=0 \
		OPTIMIZER="${CFLAGS}" || die
}

src_install() {

	dodir /usr/{bin,lib}

	make prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		sysconfdir=${D}/etc \
		localstatedir=${D}/var/lib \
		PERLDEST=${D} \
		install || die
	
	dosed "s:${D}::g" /usr/bin/AbiWord
	
	rm -f ${D}/usr/bin/abiword
	dosym /usr/bin/AbiWord /usr/bin/abiword

	dodoc BUILD COPYING *.txt, *.TXT

	# Install icon and .desktop for menu entry
	use gnome && ( \
		insinto /usr/share/pixmaps
		newins ${WORKDIR}/${P}/abidistfiles/icons/abiword_48.png AbiWord.png
		insinto /usr/share/gnome/apps/Applications
		doins ${FILESDIR}/AbiWord.desktop
	)
}

pkg_postinst() {

	# Appending installation info
	local perlver="`perl -v | grep -e "This is perl" | cut -d ' ' -f 4`"
	perlver=${perlver/v/}
	local perlarch="`perl -V | grep -e " archname" | cut -d '=' -f 4`"
	if [ -f /usr/lib/perl5/${perlver}/${perlarch}/perllocal.pod.new ] ; then
		sed -e "s:5.6.0:${perlver}:g" \
			/usr/lib/perl5/${perlver}/${perlarch}/perllocal.pod.new \
			>> /usr/lib/perl5/${perlver}/${perlarch}/perllocal.pod
		rm -rf /usr/lib/perl5/${perlver}/${perlarch}/perllocal.pod.new
	fi
}

