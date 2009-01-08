# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/eselect-news/eselect-news-20080320.ebuild,v 1.10 2009/01/08 20:35:30 ranger Exp $

DESCRIPTION="GLEP 42 news reader"
HOMEPAGE="http://paludis.pioto.org/"
SRC_URI="http://dev.gentooexperimental.org/~peper/distfiles/news.eselect-${PV}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~m68k ~mips ppc ppc64 s390 sh sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=app-admin/eselect-1.0.11"

src_install() {
	insinto /usr/share/eselect/modules
	newins "${DISTDIR}/news.eselect-${PV}" news.eselect || die
	keepdir /var/lib/gentoo/news
}

pkg_postinst() {
	local paludis_data="${ROOT}var/lib/paludis/news" gentoo_data="${ROOT}var/lib/gentoo/news"

	if [[ -d "${paludis_data}" && ! -L "${paludis_data}" ]] ; then
		einfo "Merging news data at '${paludis_data}' with '${gentoo_data}'"

		local f fname
		for f in "${paludis_data}"/*.{read,unread,skip} ; do
			fname=$(basename "${f}")
			if [[ -f "${gentoo_data}/${fname}" ]] ; then
				cat "${gentoo_data}/${fname}" >> "${f}"
			fi
			sort -u "${f}" > "${gentoo_data}/${fname}"
		done
		rm -r "${paludis_data}"
		ln -s "${gentoo_data}" "${paludis_data}"
	fi
}
