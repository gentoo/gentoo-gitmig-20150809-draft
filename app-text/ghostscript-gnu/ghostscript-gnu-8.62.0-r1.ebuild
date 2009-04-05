# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/ghostscript-gnu/ghostscript-gnu-8.62.0-r1.ebuild,v 1.2 2009/04/05 20:29:25 ranger Exp $

inherit eutils versionator flag-o-matic

DESCRIPTION="GNU Ghostscript - patched GPL Ghostscript"
HOMEPAGE="http://www.gnu.org/software/ghostscript/"

MY_P=gnu-ghostscript-${PV}
PVM=$(get_version_component_range 1-2)
SRC_URI="cjk? ( ftp://ftp.gyve.org/pub/gs-cjk/adobe-cmaps-200406.tar.gz
		ftp://ftp.gyve.org/pub/gs-cjk/acro5-cmaps-2001.tar.gz )
	mirror://gnu/ghostscript/${MY_P}.tar.bz2
	mirror://gentoo/ghostscript-gnu-8.62.0-CVE-2009-0583.patch.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="X cups cjk gtk jpeg2k"

DEP="
	>=media-libs/jpeg-6b
	>=media-libs/libpng-1.2.5
	>=sys-libs/zlib-1.1.4
	>=media-libs/tiff-3.7
	X? ( x11-libs/libXt x11-libs/libXext )
	gtk? ( >=x11-libs/gtk+-2.0 )
	cups? ( >=net-print/cups-1.1.20 )
	!app-text/ghostscript-esp
	!app-text/ghostscript-gpl"

RDEPEND="${DEP}
	cjk? ( media-fonts/arphicfonts
		media-fonts/kochi-substitute
		media-fonts/baekmuk-fonts )
	media-fonts/gnu-gs-fonts-std"

DEPEND="${DEP}
	gtk? ( dev-util/pkgconfig )"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A/adobe-cmaps-200406.tar.gz acro5-cmaps-2001.tar.gz}
	if use cjk; then
		cat "${FILESDIR}"/ghostscript-esp-8.15.2-cidfmap.cjk >> "${S}"/lib/cidfmap
		cat "${FILESDIR}"/ghostscript-esp-8.15.2-FAPIcidfmap.cjk >> "${S}"/lib/FAPIcidfmap
		cd "${S}"/Resource
		unpack adobe-cmaps-200406.tar.gz
		unpack acro5-cmaps-2001.tar.gz
	fi

	cd "${S}"

	# search path fix
	sed -i -e "s:\$\(gsdatadir\)/lib:/usr/share/ghostscript/${PVM}/$(get_libdir):" \
		-e 's:$(gsdir)/fonts:/usr/share/fonts/default/ghostscript/:' \
		-e "s:exdir=.*:exdir=/usr/share/doc/${PF}/examples:" \
		-e "s:docdir=.*:docdir=/usr/share/doc/${PF}/html:" \
		-e "s:GS_DOCDIR=.*:GS_DOCDIR=/usr/share/doc/${PF}/html:" \
		Makefile.in src/*.mak || die "sed failed"

	epatch "${WORKDIR}/${P}-CVE-2009-0583.patch" #261087
	epatch "${FILESDIR}/${P}-LDFLAGS-strip.patch"
	epatch "${FILESDIR}/${P}-CVE-misc.patch" #264614
}

src_compile() {
	econf $(use_with X x) \
		$(use_with jpeg2k jasper) \
		$(use_enable cups) \
		$(use_enable gtk) \
		--with-ijs \
		--with-jbig2dec \
		--disable-compile-inits \
		--enable-dynamic

	emake -j1 so all || die "emake failed"

	cd ijs || die
	econf
	emake || die "ijs emake failed"
}

src_install() {
	emake DESTDIR="${D}" install-so install || die "emake install failed"

	rm -fr "${D}"/usr/share/doc/${PF}/html/{README,PUBLIC}
	dodoc doc/README

	cd "${S}"/ijs
	emake DESTDIR="${D}" install || die "emake ijs install failed"
}
