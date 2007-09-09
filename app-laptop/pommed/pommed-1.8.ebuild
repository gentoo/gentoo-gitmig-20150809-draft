# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/pommed/pommed-1.8.ebuild,v 1.2 2007/09/09 00:30:36 josejx Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Daemon managing special features such as screen and keyboard \
backlight on Apple MacBook Pro/PowerBook laptops"
HOMEPAGE="http://technologeek.org/projects/pommed/index.html"
ALIOTH_NUMBER="2075"
SRC_URI="http://alioth.debian.org/frs/download.php/${ALIOTH_NUMBER}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="gtk X"

DEPEND="media-libs/alsa-lib
	x86? ( sys-apps/pciutils
		>=sys-libs/libsmbios-0.13.6 )
	amd64? (  sys-apps/pciutils
		>=sys-libs/libsmbios-0.13.6 )
	dev-libs/confuse
	sys-apps/dbus
	sys-libs/zlib
	gtk? ( >=x11-libs/gtk+-2
		>=gnome-base/libglade-2
		media-libs/audiofile )
	X? ( x11-libs/libX11 )"
RDEPEND="${DEPEND}
	virtual/eject"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch ${FILESDIR}/${PN}-1.7.patch
}

src_compile() {
	cd "${S}"/pommed
	emake CC=$(tc-getCC) OFLIB=1 || die "emake pommed failed"

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
	if use x86 || use amd64; then
		newins pommed.conf.mactel pommed.conf
	elif use ppc; then
		newins pommed.conf.pmac pommed.conf
	fi

	insinto /etc/dbus-1/system.d
	newins dbus-policy.conf pommed.conf

	dobin pommed/pommed

	newinitd "${FILESDIR}"/pommed.rc pommed

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
		doins gpomme/gpomme-c.desktop
		insinto /usr/share/gpomme/
		doins -r gpomme/themes
		doins gpomme/gpomme.glade
	fi

	if use X ; then
		dobin wmpomme/wmpomme
	fi
}
