# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/dvdrip/dvdrip-0.47_pre12.ebuild,v 1.2 2002/11/19 02:31:30 blauwers Exp $

IUSE="oggvorbis"

inherit perl-module

MY_P=${P/dvdr/Video-DVDR}
# Next three lines are to handle PRE versions
MY_P=${MY_P/_pre/_}
MY_URL="dist"
[ "${P/pre}" != "${P}" ] && MY_URL="dist/pre"

S=${WORKDIR}/${MY_P}
DESCRIPTION="dvd::rip is a graphical frontend for transcode"
SRC_URI="http://www.exit1.org/dvdrip/${MY_URL}/${MY_P}.tar.gz"
HOMEPAGE="http://www.exit1.org/dvdrip/"
SLOT="0"
LICENSE="Artistic GPL-2"
KEYWORDS="~x86"

DEPEND=">=media-video/transcode-0.6.0_pre4-r1
	media-gfx/imagemagick
	gnome-extra/gtkhtml
	dev-perl/gtk-perl
	dev-perl/Storable
	dev-perl/Event
	oggvorbis? ( media-sound/ogmtools )"

RDEPEND=">=net-analyzer/fping-2.3"

src_install () {
	perl-module_src_install
	cp -a ${S}/contrib ${D}/usr/share/doc/${P}
}
