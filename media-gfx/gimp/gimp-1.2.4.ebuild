# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gimp/gimp-1.2.4.ebuild,v 1.2 2003/05/27 17:54:31 liquidx Exp $

inherit eutils flag-o-matic

IUSE="python nls gnome aalib perl doc jpeg png tiff doc"

S=${WORKDIR}/${P}
DESCRIPTION="The GIMP"
SRC_URI="ftp://ftp.gimp.org/pub/gimp/v1.2/v${PV}/${P}.tar.bz2"
HOMEPAGE="http://www.gimp.org/"

SLOT="1.2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
LICENSE="GPL-2"

RDEPEND="=x11-libs/gtk+-1.2*
	aalib? ( >=media-libs/aalib-1.2 )
	perl? ( >=dev-perl/PDL-2.2.1
		>=dev-perl/Parse-RecDescent-1.80
		>=dev-perl/gtk-perl-0.7004 )
	python? ( >=dev-lang/python-2.0 )
	gnome? ( >=gnome-base/gnome-libs-1.4.1.2-r1 )
	tiff? ( media-libs/tiff )
	jpeg ( media-libs/jpeg )
	png? ( media-libs/libpng )"

DEPEND="nls? ( sys-devel/gettext )
	doc? ( dev-util/gtk-doc )
	>=media-libs/mpeg-lib-1.3.1
	${RDEPEND}"

src_unpack() {
	unpack ${A}
	# here for a mysterious reason
	touch ${S}/plug-ins/common/${P}.tar.bz2
}

src_compile() {

	# Strip out -fomit-frame-pointer for k6's
	is-flag "-march=k6*" && strip-flags "-fomit-frame-pointer"

	local mymake=""

	use aalib || mymake="LIBAA= AA="
	use gnome || mymake="${mymake} HELPBROWSER="
	use perl && export PERL_MM_OPT=' PREFIX=${D}/usr'

	econf \
		--with-mp \
		--with-threads \
		--disable-debug \
		--disable-print \
		`use_enable perl` \
		`use_enable python` \
		`use_enable nls` \
		`use_with jpeg libjpeg` \
		`use_with png libpng` \
		`use_with tiff libtiff` \
		`use_enable doc gtk-doc` \
		${myconf} || die

	if [ -z "`use aalib`" ] ; then 
		# Horrible automake brokenness
		cp plug-ins/common/Makefile plug-ins/common/Makefile.orig
		cat plug-ins/common/Makefile.orig | \
			sed 's/CML_explorer$(EXEEXT) aa/CML_explorer$(EXEEXT)/' \
			> plug-ins/common/Makefile
	fi

	MAKEOPTS="${MAKEOPTS} -j1"
	emake ${mymake} || die
}

src_install() {

	local mymake="" 
	use aalib || mymake="LIBAA= AA="
	use gnome || mymake="${mymake} HELPBROWSER="
  
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
		INSTALLSITEMAN1DIR=${D}/usr/share/man/man1 \
		INSTALLSITEMAN3DIR=${D}/usr/share/man/man3pm \
		INSTALLVENDORMAN1DIR=${D}/usr/share/man/man1 \
		INSTALLVENDORMAN3DIR=${D}/usr/share/man/man3pm \
		${mymake} || die "Installation failed"

	dosym gimp-1.2 /usr/bin/gimp
	#this next line closes bug #810
	dosym gimptool-1.2 /usr/bin/gimptool

	use gnome && (
		insinto /usr/share/applications
		doins ${FILESDIR}/gimp.desktop
	)
	
	preplib /usr
	
	dodoc AUTHORS COPYING ChangeLog* *MAINTAINERS README* TODO
	dodoc docs/*.txt docs/*.ps docs/Wilber* docs/quick_reference.tar.gz
}
