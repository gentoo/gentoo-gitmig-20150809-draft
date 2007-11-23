# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/pm-utils/pm-utils-0.99.4.ebuild,v 1.1 2007/11/23 06:18:27 compnerd Exp $

inherit eutils

DESCRIPTION="Suspend and hibernation utilties for HAL"
HOMEPAGE="http://pm-utils.freedesktop.org/ http://people.freedesktop.org/~hughsient/quirk/index.html"
SRC_URI="http://cvs.fedoraproject.org/repo/pkgs/pm-utils/pm-utils-0.99.4.tar.gz/a88503876f63c96b55784be91b6458d2/pm-utils-0.99.4.tar.gz
	http://cvs.fedora.redhat.com/viewcvs/*checkout*/devel/pm-utils/pm-utils-0.99.3-cfg.patch"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${DISTDIR}/pm-utils-0.99.3-cfg.patch"
}

src_compile() {
	econf $(use_enable debug) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
