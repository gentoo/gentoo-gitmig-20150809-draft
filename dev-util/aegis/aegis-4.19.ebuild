# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/aegis/aegis-4.19.ebuild,v 1.1 2004/11/02 02:30:02 karltk Exp $

IUSE="tcltk"

DESCRIPTION="A transaction based revision control system"
SRC_URI="mirror://sourceforge/aegis/${P}.tar.gz"
HOMEPAGE="http://aegis.sourceforge.net"

DEPEND="sys-libs/zlib
	sys-devel/gettext
	sys-apps/groff
	sys-devel/bison
	tcltk? ( >=dev-lang/tk-8.3 )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~alpha ~ppc"

src_compile() {
	# By default aegis configure puts shareable read/write files (locks etc)
	# in ${prefix}/com/aegis but the FHS says /var/lib/aegis can be shared.

	myconf="${myconf} --with-nlsdir=/usr/share/locale"

	econf \
		--sharedstatedir=/var/lib/aegis \
		${myconf} || die "./configure failed"

	# Second ebuild causes redefined/undefined function errors
	make clean

	# not emake safe, I think
	make || die
}

src_install () {
	make RPM_BUILD_ROOT=${D} install || die

	# Alas gentoo appears to have no profile.d mechanism, so:
	rm ${D}/etc/profile.d/aegis.sh
	rm ${D}/etc/profile.d/aegis.csh
	rmdir ${D}/etc/profile.d
	rmdir ${D}/etc

	# OK so ${D}/var/lib/aegis gets UID=3, but for some
	# reason so do the files under /usr/share, even though
	# they are read-only.
	chown -R root:root ${D}/usr/share
	dodoc lib/en/*

	# Link to share dir so user has a chance of noticing it.
	dosym /usr/share/aegis /usr/share/doc/${PF}/scripts

	# Config file examples are documentation.
	mv ${D}/usr/share/aegis/config.example ${D}/usr/share/doc/${PF}/

	dodoc LICENSE BUILDING MANIFEST README
}
