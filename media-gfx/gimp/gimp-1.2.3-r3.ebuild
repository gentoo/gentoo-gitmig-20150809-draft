# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gimp/gimp-1.2.3-r3.ebuild,v 1.14 2004/01/30 05:52:20 drobbins Exp $

inherit eutils flag-o-matic

DESCRIPTION="The GIMP"
HOMEPAGE="http://www.gimp.org/"
SRC_URI="ftp://ftp.gimp.org/pub/gimp/v1.2/v${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="1.2"
KEYWORDS="x86 ppc sparc alpha"
IUSE="python nls gnome aalib perl"

RDEPEND="=x11-libs/gtk+-1.2*
	aalib? ( >=media-libs/aalib-1.2 )
	perl? ( >=dev-perl/PDL-2.2.1
		>=dev-perl/Parse-RecDescent-1.80
		>=dev-perl/gtk-perl-0.7004 )
	python? ( >=dev-lang/python-2.0 )
	gnome? ( >=gnome-base/gnome-libs-1.4.1.2-r1 )"
DEPEND="nls? ( sys-devel/gettext )
	>=sys-devel/autoconf-2.58
	sys-devel/automake
	>=media-libs/mpeg-lib-1.3.1
	${RDEPEND}"

src_unpack() {
	if [ "`use threads`" ]; then
		eerror "I'm sorry I can't build against a threaded perl,"
		eerror "please remerge perl and libperl without"
		eerror "'USE=threads' and try again.  (Note: this message"
		eerror "is triggered by having threads in USE so you must"
		eerror "leave threads out of your USE var when merging"
		eerror "gimp."
		die "Not compatible with threaded perl"
	fi
	unpack ${A}

	cd ${S}/plug-ins/common
	# compile with nonstandard psd_save plugin
	cp ${FILESDIR}/psd_save.c .
	epatch ${FILESDIR}/${PF}-gentoo.diff
	cd ${S}

	if [ -f ${ROOT}/usr/share/gettext/config.rpath ] ; then
		cp -f ${ROOT}/usr/share/gettext/config.rpath ${S}
	else
		touch ${S}/config.rpath
		chmod 0755 ${S}/config.rpath
	fi

	echo ">>> Reconfiguring package..."
	export WANT_AUTOMAKE=1.4
	export WANT_AUTOCONF=2.1
	aclocal -I . -I ${S}/plug-ins/perl
	automake --add-missing --gnu
# Do not run autoreconf, or even autoconf, as it (autoreconf at least)
# needs cvs installed, and breaks configure (locales are not installed).
# Our psd_save patch anyhow only touch .am files, so only automake is
# needed ....  This should fix bug #8490, #6021 and #9621.
#
# <azarah@gentoo.org> (2 Nov 2002)
#
#	autoreconf --install --symlink &> ${T}/autoreconf.log || ( \
#		echo "DEBUG: working directory is: `pwd`" >>${T}/autoreconf.log
#		eerror "Reonfigure failed, please attatch the contents of:"
#		eerror
#		eerror "  ${T}/autoreconf.log"
#		eerror
#		eerror "in your bugreport."
#		# we need an error here, else the ebuild do not die
#		exit 1
#	) || die "running autoreconf failed"
	touch plug-ins/common/gimp-1.2.3.tar.bz2
}

src_compile() {


	# Strip out -fomit-frame-pointer for k6's
	is-flag "-march=k6-3" && strip-flags "-fomit-frame-pointer"
	is-flag "-march=k6-2" && strip-flags "-fomit-frame-pointer"
	is-flag "-march=k6" && strip-flags "-fomit-frame-pointer"


	local myconf=""
	local mymake=""
	local myvars=""
	if [ -z "`use nls`" ] ; then
		myconf="${myconf} --disable-nls"
	fi

	if [ -z "`use perl`" ] ; then
		myconf="${myconf} --disable-perl"
	else
		export  PERL_MM_OPT=' PREFIX=${D}/usr'
		myconf="${myconf} --enable-perl"
	fi

	if [ -z "`use python`" ] ; then
		myconf="${myconf} --disable-python"
	else
		myconf="${myconf} --enable-python"
	fi

	if [ -z "`use aalib`" ] ; then
		mymake="LIBAA= AA="
	fi

	if [ -z "`use gnome`" ] ; then
		mymake="${mymake} HELPBROWSER="
	fi

	econf \
		--with-mp \
		--with-threads \
		--disable-debug \
		${myconf} || die

	if [ -z "`use aalib`" ] ; then
		# Horrible automake brokenness
		cp plug-ins/common/Makefile plug-ins/common/Makefile.orig
		cat plug-ins/common/Makefile.orig | \
			sed 's/CML_explorer$(EXEEXT) aa/CML_explorer$(EXEEXT)/' \
			> plug-ins/common/Makefile
	fi

	# Doesn't work with -j 4 (hallski)
	MAKEOPTS="-j1" emake ${mymake} || die
}

src_install() {

	local mymake=""
	if [ -z "`use aalib`" ] ; then
		mymake="LIBAA= AA="
	fi

	if [ -z "`use gnome`" ] ; then
		mymake="${mymake} HELPBROWSER="
	fi

	dodir /usr/lib/gimp/1.2/plug-ins

	einstall \
		gimpdatadir=${D}/usr/share/gimp/1.2 \
		gimpsysconfdir=${D}/etc/gimp/1.2 \
		PREFIX=${D}/usr \
		INSTALLPRIVLIB=${D}/usr/lib/perl5 \
		INSTALLSCRIPT=${D}/usr/bin \
		INSTALLSITELIB=${D}/usr/lib/perl5/site_perl \
		INSTALLBIN=${D}/usr/bin \
		INSTALLMAN1DIR=${D}/usr/share/man/man1 \
		INSTALLMAN3DIR=${D}/usr/share/man/man3 \
		${mymake} || die "Installation failed"

	dosym gimp-1.2 /usr/bin/gimp
	#this next line closes bug #810
	dosym gimptool-1.2 /usr/bin/gimptool

	if [ "`use gnome`" ] && [ -d ${ROOT}/usr/share/applications ]
	then
		insinto /usr/share/applications
		doins ${FILESDIR}/gimp.desktop
	fi

	preplib /usr

	dodoc AUTHORS COPYING ChangeLog* *MAINTAINERS README* TODO
	dodoc docs/*.txt docs/*.ps docs/Wilber* docs/quick_reference.tar.gz
	dohtml -r devel-docs
	docinto devel
	dodoc devel-docs/*.txt
}
