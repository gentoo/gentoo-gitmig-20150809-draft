# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/fontconfig/fontconfig-2.1-r1.ebuild,v 1.23 2004/06/11 12:58:50 vapier Exp $

inherit debug eutils gcc

S="${WORKDIR}/fcpackage.${PV/\./_}/fontconfig"
DESCRIPTION="A library for configuring and customizing font access"
HOMEPAGE="http://freedesktop.org/"
SRC_URI="http://pdx.freedesktop.org/software/fontconfig/releases/fcpackage.${PV/\./_}.tar.gz"

LICENSE="fontconfig"
SLOT="1.0"
KEYWORDS="x86 ppc sparc mips alpha hppa amd64"
IUSE=""

# Seems like patches in freetype-2.1.2-r2 fixes bug #10028
DEPEND=">=media-libs/freetype-2.1.2-r2
	>=dev-libs/expat-1.95.3
	>=sys-apps/ed-0.2"

fc_setup() {
	# Do not use 'cc' to compile
	export CC="$(gcc-getCC)"
}

src_unpack() {
	unpack ${A}

	cd ${S}
	local PPREFIX="${FILESDIR}/patch/${PN}"

	# Cvs update from XFree86 tree
	epatch ${PPREFIX}-${PV}-cvs-update-20021221.patch

	# Some patches from Redhat
	epatch ${PPREFIX}-2.0-defaultconfig.patch
	epatch ${PPREFIX}-${PV}-slighthint.patch
	# Blacklist certain fonts that freetype can't handle
	epatch ${PPREFIX}-0.0.1.020826.1330-blacklist.patch
	# Fix config script to alway include X11 fontpath and remove date
	epatch ${PPREFIX}-${PV}-x11fontpath-date-configure-v2.patch
	# fix font width bug with cjk fonts
	epatch ${PPREFIX}-${PV}-fixedwidth.patch
}

src_compile() {
	fc_setup

	[ "${ARCH}" == "alpha" -a "${CC}" == "ccc" ] && \
		die "Dont compile fontconfig with ccc, it doesnt work very well"

	econf \
		--x-includes=/usr/X11R6/include \
		--x-libraries=/usr/X11R6/lib || die

	emake || die
}

src_install() {
	fc_setup

	einstall confdir=${D}/etc/fonts \
		datadir=${D}/usr/share || die

	insinto /etc/fonts
	doins ${S}/fonts.conf
	newins ${S}/fonts.conf fonts.conf.new

	cd ${S}

	newman fc-cache/fc-cache.man fc-cache.1
	newman fc-list/fc-list.man fc-list.1
	newman src/fontconfig.man fontconfig.3
	dodoc AUTHORS ChangeLog NEWS README
}

pkg_postinst() {
	# Changes should be made to /etc/fonts/local.conf, and as we had
	# too much problems with broken fonts.conf, we force update it ...
	# <azarah@gentoo.org> (11 Dec 2002)
	ewarn "Please make fontconfig related changes to /etc/fonts/local.conf,"
	ewarn "and NOT to /etc/fonts/fonts.conf, as it will be replaced!"
	mv -f ${ROOT}/etc/fonts/fonts.conf.new ${ROOT}/etc/fonts/fonts.conf
	rm -f ${ROOT}/etc/fonts/._cfg????_fonts.conf

	if [ "${ROOT}" = "/" ]
	then
		echo
		einfo "Creating font cache..."
		HOME="/root" /usr/bin/fc-cache -f
	fi
}

