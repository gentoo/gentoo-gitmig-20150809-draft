# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/sharutils/sharutils-4.2.1-r7.ebuild,v 1.4 2004/04/10 07:20:17 mr_bones_ Exp $

inherit eutils

DESCRIPTION="Tools to deal with shar archives"
HOMEPAGE="http://www.gnu.org/software/sharutils/"
SRC_URI="mirror://gentoo/${P}.tar.gz
	mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha ~hppa ~ia64 ~ppc64 s390"
IUSE="nls"

DEPEND="sys-apps/texinfo
	nls? ( >=sys-devel/gettext-0.10.35 )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-r6-gentoo.diff

	cd ${S}/po
	cp ja_JP.EUC.po ja.po
	cp ja_JP.EUC.gmo ja.gmo
	sed -i -e 's/aangemaakt/aangemaakt\\n/' nl.po
	sed -i -e 's/de %dk/de %dk\\n/' pt.po
}

src_compile() {
	local myconf=
	use nls || myconf="${myconf} --disable-nls"

	econf ${myconf} || die
	emake || die
}

src_install() {
	local x=

	einstall \
		localedir=${D}/usr/share/locale \
		|| die

	doman doc/*.[15]
	# Remove some strange locales
	cd ${D}/usr/share/locale
	for x in *.
	do
	  rm -rf ${x}
	done
	rm -rf ${D}/usr/lib

	cd ${S}
	dodoc AUTHORS BACKLOG COPYING ChangeLog ChangeLog.OLD \
		NEWS README README.OLD THANKS TODO
}


