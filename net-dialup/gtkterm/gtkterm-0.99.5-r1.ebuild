# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/gtkterm/gtkterm-0.99.5-r1.ebuild,v 1.2 2007/05/02 07:56:36 genone Exp $

DESCRIPTION="A serial port terminal written in GTK+, similar to Windows' HyperTerminal."
HOMEPAGE="http://www.jls-info.com/julien/linux/"
SRC_URI="http://www.jls-info.com/julien/linux/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE="nls"

RDEPEND=">=x11-libs/gtk+-2.0
	x11-libs/vte"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

# Supported languages and translated documentation
# Be sure all languages are prefixed with a single space!
MY_AVAILABLE_LINGUAS=" fr hu ru"
IUSE="${IUSE} ${MY_AVAILABLE_LINGUAS// / linguas_}"

src_unpack() {
	unpack ${A}

	if use nls ; then
		cp "${FILESDIR}"/ru.po "${S}"/po/ || die "adding Russian language support failed"
	fi
}

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	einstall || die "einstall failed"

	if use nls; then
		cd "${S}/po"
		local MY_LINGUAS="" lang

		for lang in ${MY_AVAILABLE_LINGUAS} ; do
			if use linguas_${lang} ; then
				MY_LINGUAS="${MY_LINGUAS} ${lang}"
			fi
		done
		if [[ -z "${MY_LINGUAS}" ]] ; then
			#If no language is selected, install 'em all
			MY_LINGUAS="${MY_AVAILABLE_LINGUAS}"
		fi

		elog "Locale messages will be installed for following languages:"
		elog "   ${MY_LINGUAS}"

		for lang in ${MY_LINGUAS}; do
			msgfmt -o ${lang}.mo ${lang}.po && \
				insinto /usr/share/locale/${lang}/LC_MESSAGES && \
				newins ${lang}.mo gtkterm.mo || \
					die "failed to install locale messages for ${lang} language"
		done
	fi
}
