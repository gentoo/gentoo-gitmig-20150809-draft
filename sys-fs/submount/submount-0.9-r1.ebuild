# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/submount/submount-0.9-r1.ebuild,v 1.2 2004/10/13 01:06:10 latexer Exp $

inherit eutils kernel-mod

IUSE=""

DESCRIPTION="Submount is a new attempt to solve the removable media problem for Linux."
HOMEPAGE="http://submount.sourceforge.net/"

DEPEND="virtual/linux-sources"

SLOT="${KV}"

LICENSE="GPL-2"
KEYWORDS="~x86 ~alpha ~ppc ~sparc ~amd64"

if [ "${KV_MINOR}" == "4" ]
then
	EXTRA_V="-2.4"
else
	EXTRA_V=""
	RESTRICT=nouserpriv
fi

MY_P="${PN}${EXTRA_V}-${PV}"
S="${WORKDIR}/${MY_P}"
KMOD_SOURCES="${MY_P}.tar.gz"

SRC_URI="mirror://sourceforge/${PN}/${KMOD_SOURCES}"

src_unpack()
{
	unpack ${A}
	cd ${S}
	kernel-mod_getversion

	if [ "${KV_MINOR}" -gt 5 ]
	then
		if [ "${KV_PATCH}" -gt 5 ]
		then
			sed -i "s:SUBDIRS=:M=:" \
				${S}/subfs${EXTRA_V}-${PV}/Makefile
		else
			eerror "This version of submount requires a kernel of 2.6.6 or greater"
			die "Too old of a kernel found."
		fi
	fi
}

src_compile ()
{
	cd ${S}/subfs${EXTRA_V}-${PV}
	set_arch_to_kernel
	emake KDIR=${ROOT}/usr/src/linux || die
	set_arch_to_portage

	cd ${S}/submountd${EXTRA_V}-${PV}
	econf \
	--sbindir=/sbin \
	|| die "Confugure error"

	make || die "Make error"
}

src_install ()
{
	local KV_OBJ
	if [ "${KV_MINOR}" -gt 4 ]
	then
		KV_OBJ=ko
	else
		KV_OBJ=o
	fi

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
	if [ "${ROOT}" = / ]
	then
	[ -x /usr/sbin/update-modules ] && /usr/sbin/update-modules
	fi
}
