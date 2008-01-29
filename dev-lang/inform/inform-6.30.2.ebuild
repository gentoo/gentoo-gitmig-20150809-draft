# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/inform/inform-6.30.2.ebuild,v 1.3 2008/01/29 21:20:41 grobian Exp $

inherit versionator

DESCRIPTION="design system for interactive fiction"
HOMEPAGE="http://www.inform-fiction.org/"
SRC_URI="http://mirror.ifarchive.org/if-archive/infocom/compilers/inform6/source/${P}.tar.gz"

LICENSE="Inform"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=""

src_install() {
	make DESTDIR="${D}" install || die "Install failed!"

	dodoc AUTHORS NEWS README VERSION

	docinto tutorial
	dodoc tutor/README tutor/*.txt tutor/*.inf

	# correct the placement of a few things
	mv ${D}/usr/share/${PN}/manual ${D}/usr/share/doc/${PF}/html

	# fix the symlink foo
	dosym /usr/bin/inform-$(get_version_component_range 1-2) /usr/bin/inform

	# symlinks for libraries
	rmdir ${D}/usr/share/inform/{include,module}
}
