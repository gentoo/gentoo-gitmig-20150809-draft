# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/xz-utils/xz-utils-4.999.9_beta.ebuild,v 1.3 2009/12/06 00:02:10 vapier Exp $

# Remember: we cannot leverage autotools in this ebuild in order
#           to avoid circular deps with autotools

EAPI="2"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="git://ctrl.tukaani.org/xz.git"
	inherit git autotools
	SRC_URI=""
	EXTRA_DEPEND="sys-devel/gettext dev-util/cvs >=sys-devel/libtool-2" #272880 286068
else
	MY_P="${PN/-utils}-${PV/_}"
	SRC_URI="http://tukaani.org/xz/${MY_P}.tar.gz"
	KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
	S=${WORKDIR}/${MY_P}
	EXTRA_DEPEND=
fi

inherit eutils

DESCRIPTION="utils for managing LZMA compressed files"
HOMEPAGE="http://tukaani.org/xz/"

LICENSE="LGPL-2.1"
SLOT="0"
IUSE="nls static-libs +threads"

RDEPEND="!app-arch/lzma
	!app-arch/lzma-utils
	!<app-arch/p7zip-4.57"
DEPEND="${RDEPEND}
	${EXTRA_DEPEND}"

if [[ ${PV} == "9999" ]] ; then
src_unpack() {
	git_src_unpack
	cd "${S}"
	./autogen.sh || die
}
fi

src_configure() {
	econf \
		--enable-dynamic=yes \
		$(use_enable nls) \
		$(use_enable threads) \
		$(use_enable static-libs static)
}

src_install() {
	emake install DESTDIR="${D}" || die
	rm "${D}"/usr/share/doc/xz/COPYING* || die
	mv "${D}"/usr/share/doc/{xz,${PF}} || die
	prepalldocs
	dodoc AUTHORS ChangeLog NEWS README THANKS
}
