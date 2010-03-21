# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/aspell/aspell-0.60.6-r1.ebuild,v 1.6 2010/03/21 14:52:34 ranger Exp $

# N.B. This is before inherit of autotools, as autotools.eclass adds the
# relevant dependencies to DEPEND.
WANT_AUTOMAKE="1.10"

inherit libtool eutils flag-o-matic autotools

DESCRIPTION="A spell checker replacement for ispell"
HOMEPAGE="http://aspell.net/"
SRC_URI="mirror://gnu/aspell/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ppc64 ~s390 ~sh ~sparc ~x86 ~sparc-fbsd ~x86-fbsd"
IUSE="nls examples"
# Note; app-text/aspell-0.6 and app-dicts/aspell-en-0.6 must go stable together

# Build PDEPEND from list of language codes provided in the tree.
# The PDEPEND string is static - this code just makes it easier to maintain.
def="app-dicts/aspell-en"
for l in \
	"af" "be" "bg" "br" "ca" "cs" "cy" "da" "de" "el" \
	"en" "eo" "es" "et" "fi" "fo" "fr" "ga" "gl" "he" \
	"hr" "is" "it" "la" "lt" "nl" "no" "pl" "pt" "pt_BR" \
	"ro" "ru" "sk" "sl" "sr" "sv" "uk" "vi" ; do
	dep="linguas_${l}? ( app-dicts/aspell-${l/pt_BR/pt-br} )"
	[[ ${l} = "de" ]] &&
		dep="linguas_de? ( || ( app-dicts/aspell-de app-dicts/aspell-de-alt ) )"
	[[ -z ${PDEPEND} ]] &&
		PDEPEND="${dep}" ||
		PDEPEND="${PDEPEND}
${dep}"
	def="!linguas_${l}? ( ${def} )"
	IUSE="${IUSE} linguas_${l}"
done
PDEPEND="${PDEPEND}
${def}"

RDEPEND=">=sys-libs/ncurses-5.2
	nls? ( virtual/libintl )
	!=app-dicts/aspell-en-0.5*"
# English dictionary 0.5 is incompatible with aspell-0.6

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/aspell-0.60.3-templateinstantiations.patch"
	epatch "${FILESDIR}/${PN}-0.60.5-nls.patch"

	rm m4/lt* m4/libtool.m4
	eautoreconf
	elibtoolize --reverse-deps
}

src_compile() {
	filter-flags -fno-rtti
	filter-flags -fvisibility=hidden #77109
	filter-flags -maltivec -mabi=altivec
	use ppc && append-flags -mno-altivec

	# Was bug #46432. Ncurses changed linking with gpm, from NEWS:
	# "20041009 change GPM initialization, using dl library to load it dynamically
	# at runtime (Debian #110586)"
	# and as a side effect it looks like we don't need add gpm library. (20090302)
	#built_with_use sys-libs/ncurses gpm && mylibs="-lgpm"
	LIBS="${mylibs}" econf \
		$(use_enable nls) \
		--disable-static \
		--sysconfdir=/etc/aspell \
		--enable-docdir=/usr/share/doc/${PF}

	emake || die "compilation failed"
}

src_install() {
	dodoc README* TODO || die "installing docs failed"

	emake DESTDIR="${D}" install || die "installation failed"
	mv "${D}"/usr/share/doc/${PF}/man-html "${D}"/usr/share/doc/${PF}/html
	mv "${D}"/usr/share/doc/${PF}/man-text "${D}"/usr/share/doc/${PF}/text

	# install ispell/aspell compatibility scripts
	exeinto /usr/bin
	newexe scripts/ispell ispell-aspell
	newexe scripts/spell spell-aspell

	if use examples ; then
		cd examples
		make clean || die
		docinto examples
		dodoc "${S}"/examples/* || die "installing examples failed"
	fi
}

pkg_postinst() {
	elog "In case LINGUAS was not set correctly you may need to install"
	elog "dictionaries now. Please choose an aspell-<LANG> dictionary or"
	elog "set LINGUAS correctly and let aspell pull in required packages."
	elog "After installing an aspell dictionary for your language(s),"
	elog "You may use the aspell-import utility to import your personal"
	elog "dictionaries from ispell, pspell and the older aspell"
}
