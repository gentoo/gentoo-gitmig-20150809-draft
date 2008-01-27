# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/aegis/aegis-4.19.ebuild,v 1.7 2008/01/27 10:15:36 grobian Exp $

IUSE="tk"

DESCRIPTION="A transaction based revision control system"
SRC_URI="mirror://sourceforge/aegis/${P}.tar.gz"
HOMEPAGE="http://aegis.sourceforge.net"

DEPEND="sys-libs/zlib
	sys-devel/gettext
	sys-apps/groff
	sys-devel/bison
	tk? ( >=dev-lang/tk-8.3 )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~ppc sparc x86"

src_compile() {
	# By default aegis configure puts shareable read/write files (locks etc)
	# in ${prefix}/com/aegis but the FHS says /var/lib/aegis can be shared.

	econf \
		--sharedstatedir=/var/lib/aegis \
		--with-nlsdir=/usr/share/locale \
		|| die "./configure failed"

	# Second ebuild causes redefined/undefined function errors
	make clean

	# not emake safe, I think
	make || die
}

src_install () {
	make RPM_BUILD_ROOT="${D}" install || die

	# Alas gentoo appears to have no profile.d mechanism, so:
	rm "${D}"/etc/profile.d/aegis.sh
	rm "${D}"/etc/profile.d/aegis.csh
	rmdir "${D}"/etc/profile.d
	rmdir "${D}"/etc

	# OK so ${D}/var/lib/aegis gets UID=3, but for some
	# reason so do the files under /usr/share, even though
	# they are read-only.
	chown -R root:0 "${D}"/usr/share
	dodoc lib/en/*

	# Link to share dir so user has a chance of noticing it.
	dosym /usr/share/aegis /usr/share/doc/${PF}/scripts

	# Config file examples are documentation.
	mv "${D}"/usr/share/aegis/config.example "${D}"/usr/share/doc/${PF}/

	dodoc LICENSE BUILDING MANIFEST README
}
