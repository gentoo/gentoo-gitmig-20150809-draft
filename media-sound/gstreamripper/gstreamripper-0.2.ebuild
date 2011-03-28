# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gstreamripper/gstreamripper-0.2.ebuild,v 1.14 2011/03/28 15:24:42 ssuominen Exp $

EAPI=4
inherit eutils

MY_P=GStreamripperX-${PV}

DESCRIPTION="A GTK+ toolkit based frontend for streamripper"
HOMEPAGE="http://sourceforge.net/projects/gstreamripper/"
SRC_URI="mirror://sourceforge/gstreamripper/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE=""

COMMON_DEPEND="x11-libs/gtk+:2"
RDEPEND="${COMMON_DEPEND}
	media-sound/streamripper"
DEPEND="${COMMON_DEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/${MY_P}

src_install() {
	local docdir=/usr/share/doc/${PF}

	emake \
		DESTDIR="${D}" \
		gstreamripperxdocdir=${docdir} \
		install || die

	rm -f "${D}"/${docdir}/{COPYING,NEWS,TODO}

	make_desktop_entry gstreamripperx GStreamripperX
}
