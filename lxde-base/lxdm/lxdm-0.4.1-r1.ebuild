# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/lxde-base/lxdm/lxdm-0.4.1-r1.ebuild,v 1.2 2012/05/04 05:50:38 jdhore Exp $

EAPI="2"

inherit eutils autotools

DESCRIPTION="LXDE Display Manager"
HOMEPAGE="http://lxde.org"
SRC_URI="mirror://sourceforge/lxde/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="debug gtk3 nls"

RDEPEND="sys-libs/pam
	sys-auth/consolekit
	x11-libs/libxcb
	gtk3? ( x11-libs/gtk+:3 )
	!gtk3? ( x11-libs/gtk+:2 )
	nls? ( sys-devel/gettext )"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.40
	virtual/pkgconfig"

src_configure() {
	econf	--enable-password \
		--with-pam \
		--with-x \
		--with-xconn=xcb \
		$(use_enable gtk3) \
		$(use_enable nls) \
		$(use_enable debug) \
		|| die "econf failed"
}

src_prepare() {
	# Upstream bug, tarball contains pre-made lxdm.conf
	rm "${S}"/data/lxdm.conf || die

	# There is consolekit
	epatch "${FILESDIR}/${P}-pam_console-disable.patch"
	# Fix null pointer dereference, backported from git
	epatch "${FILESDIR}/${P}-git-fix-null-pointer-deref.patch"

	# this replaces the bootstrap/autogen script in most packages
	eautoreconf

	# process LINGUAS
	if use nls; then
		einfo "Running intltoolize ..."
		intltoolize --force --copy --automake || die
		strip-linguas -i "${S}/po" || die
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS README TODO || die
	exeinto /etc/lxdm
	doexe "${FILESDIR}"/xinitrc || die
}

pkg_postinst() {
	echo
	elog "LXDM in the early stages of development!"
	echo
}
