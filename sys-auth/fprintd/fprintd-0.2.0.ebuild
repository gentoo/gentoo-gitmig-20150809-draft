# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/fprintd/fprintd-0.2.0.ebuild,v 1.1 2010/10/27 12:10:18 xmw Exp $

EAPI=3

inherit autotools toolchain-funcs versionator

DESCRIPTION="D-Bus to offer libfprint functionality"
HOMEPAGE="http://cgit.freedesktop.org/libfprint/fprintd/"
MY_PV="V_$(replace_all_version_separators _)"
SRC_URI="http://cgit.freedesktop.org/libfprint/${PN}/snapshot/${MY_PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc pam static-libs"

RDEPEND="
	dev-libs/dbus-glib
	dev-libs/glib:2
	sys-auth/libfprint
	sys-auth/polkit
	pam? ( sys-libs/pam )
	"
DEPEND="${RDEPEND}
	dev-util/gtk-doc
	dev-util/intltool
	doc? ( dev-libs/libxml2 dev-libs/libxslt )
	"

S=${WORKDIR}/${MY_PV}

src_prepare() {
	cp /usr/share/gtk-doc/data/gtk-doc.make . || die
	sed -e '/SUBDIRS/s: po::' -i Makefile.am || die
	eautoreconf
	intltoolize || die
}

src_configure() {
	econf $(use_enable pam) \
		$(use_enable static-libs static) \
		$(use_enable doc gtk-doc-html)
}

src_install() {
	emake DESTDIR="${D}" install \
		pammoddir=/$(get_libdir)/security || die

	keepdir /var/lib/fprint || die

	dodoc AUTHORS ChangeLog NEWS README TODO || die
	if use doc ; then
		insinto ${EPREFIX}/usr/share/doc/${PF}/html
		doins doc/{fprintd-docs,version}.xml || die
		insinto ${EPREFIX}/usr/share/doc/${PF}/html/dbus
		doins doc/dbus/net.reactivated.Fprint.{Device,Manager}.ref.xml || die
	fi
}

pkg_postinst() {
	elog "You can add the following line to your /etc/pam.d/system-auth"
	elog
	elog "    auth    sufficient      pam_fprintd.so"
	elog
	elog "to enable the PAM module for authentication."
	elog "But don't lock yourself out, keep one terminal open!"
}
