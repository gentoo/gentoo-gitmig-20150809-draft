# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/pommed/pommed-1.2.ebuild,v 1.1 2007/03/04 19:31:03 cedk Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Daemon managing special features such as screen and keyboard \
backlight on Apple MacBook Pro/PowerBook laptops"
HOMEPAGE="http://technologeek.org/projects/pommed/index.html"
SRC_URI="http://alioth.debian.org/frs/download.php/1831/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="gtk X"

DEPEND="sys-apps/pciutils
	media-libs/alsa-lib
	sys-libs/libsmbios
	dev-libs/confuse
	sys-apps/dbus
	sys-libs/zlib
	gtk? ( x11-libs/gtk+
		media-libs/audiofile )
	X? ( x11-libs/libX11 )"
RDEPEND="${DEPEND}
	sys-apps/eject"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch ${FILESDIR}/${P}.patch
}

src_compile() {
	cd "${S}"/pommed
	emake CC=$(tc-getCC) || die "emake pommed failed"

	if use gtk; then
		cd "${S}"/gpomme
		local POFILES=""
		for LANG in ${LINGUAS}; do
			if [ -f po/${LANG}.po ]; then
				POFILES="${POFILES} po/${LANG}.po"
			fi
		done
		emake CC=$(tc-getCC) POFILES="${POFILES}" || die "emake gpomme failed"
	fi
	if use X; then
		cd "${S}"/wmpomme
		emake CC=$(tc-getCC) || die "emake wmpomme failed"
	fi
}

src_install() {
	insinto /etc
	doins pommed.conf.{pmac,mactel}

	insinto /etc/dbus-1/system.d
	doins dbus-policy.conf

	dobin pommed/pommed

	newinitd ${FILESDIR}/pommed.rc pommed

	dodoc AUTHORS ChangeLog README TODO

	if use gtk ; then
		dobin gpomme/gpomme
		for LANG in ${LINGUAS}; do
			if [ -f gpomme/po/${LANG}.mo ]; then
				einfo "Installing lang ${LANG}"
				insinto /usr/share/locale/${LANG}/LC_MESSAGES/
				doins gpomme/po/${LANG}.mo
			fi
		done

		insinto /usr/share/applications
		doins gpomme/gpomme.desktop
		insinto /usr/share/gpomme/
		doins -r gpomme/themes
	fi

	if use X ; then
		dobin wmpomme/wmpomme
	fi
}
