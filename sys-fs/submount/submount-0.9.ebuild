# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/submount/submount-0.9.ebuild,v 1.2 2004/04/16 19:08:30 mr_bones_ Exp $

inherit kmod

IUSE=""

DESCRIPTION="Submount is a new attempt to solve the removable media problem for Linux."
HOMEPAGE="http://submount.sourceforge.net/"

DEPEND="virtual/linux-sources
	sys-kernel/config-kernel"

SLOT="${KV}"

LICENSE="GPL-2"
KEYWORDS="x86 ~alpha ~ppc ~sparc"

if [ "${KV_MINOR}" == "4" ]
then
	KMOD_SOURCES="${PN}-2.4-${PV}.tar.gz"
	S=${WORKDIR}/${PN}-2.4-${PV}
	EXTRA_V=-2.4
else
	KMOD_SOURCES="${P}.tar.gz"
	S=${WORKDIR}/${P}
	EXTRA_V=""
	RESTRICT=nouserpriv
fi

SRC_URI="mirror://sourceforge/${PN}/${KMOD_SOURCES}"

src_unpack ()
{
	# Unpack and set some variables
	kmod_src_unpack
}

src_compile ()
{
	cd ${S}/subfs${EXTRA_V}-${PV}
	kmod_src_compile

	cd ${S}/submountd${EXTRA_V}-${PV}
	econf \
	--sbindir=/sbin \
	|| die "Confugure error"

	make || die "Make error"
}

src_install ()
{
	cd ${S}/submountd${EXTRA_V}-${PV}
	make install DESTDIR=${D} mandir=/usr/share/man

	cd ${S}/subfs${EXTRA_V}-${PV}

	insinto /lib/modules/${KV}/fs/subfs

	doins subfs.$KV_OBJ

	cd ${S}
	./rename-docs ${PV}
	dodoc README* COPYING INSTALL*
}

pkg_postinst ()
{
	kmod_pkg_postinst

	if [ "${ROOT}" = / ]
	then
	[ -x /usr/sbin/update-modules ] && /usr/sbin/update-modules
	fi
}
