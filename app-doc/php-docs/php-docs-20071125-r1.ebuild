# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/php-docs/php-docs-20071125-r1.ebuild,v 1.3 2007/12/06 00:53:59 mr_bones_ Exp $

EAPI="1"

DESCRIPTION="HTML documentation for PHP"
HOMEPAGE="http://www.php.net/download-docs.php"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="+linguas_en"
SRC_URI="linguas_en? ( http://dev.gentooexperimental.org/~jakub/distfiles/${P}_en.tar.gz
			mirror://gentoo/${P}_en.tar.gz )"

RESTRICT="strip binchecks"

LANGS="cs da de el es fi fr he hu it ja ko nl pl pt_BR ro ru sk sv zh_CN zh_TW"
for lang in ${LANGS} ; do
	IUSE="${IUSE} linguas_${lang}"
	SRC_URI="${SRC_URI}
		linguas_${lang}? ( http://dev.gentooexperimental.org/~jakub/distfiles/${P}_${lang}.tar.gz
				    mirror://gentoo/${P}_${lang}.tar.gz )"
done

S=${WORKDIR}

src_unpack() {
	for lang in en ${LANGS} ; do
		if use linguas_${lang} ; then
			mkdir ${lang}
			pushd ${lang} >/dev/null
			unpack ${P}_${lang}.tar.gz || die "unpack failed on ${lang}"
			popd >/dev/null
		fi
	done
}

pkg_preinst() {
	# remove broken/stale symlink created by previous ebuilds
	[[ -L ${ROOT}/usr/share/php-docs ]] && rm -f "${ROOT}"/usr/share/php-docs
}

src_install() {
	for lang in en ${LANGS} ; do
		if use linguas_${lang} ; then
			pushd ${lang}/html >/dev/null
			ebegin "Installing ${lang} manual, this will take a while..."
			# the whole structure is too much to do with a simple dohtml *
			for x in a b c d e f g h i j k l m n o p q r s t u v w x y z ; do
				files="$(echo function.${x}*)"
				[[ -n ${files} ]] || continue;

				dohtml function.${x}*
				rm function.${x}*
			done

			# what's left will fit into a single dohtml *
			dohtml -r *
			popd >/dev/null
			dodir /usr/share/doc/${PF}/html/${lang}
			mv "${D}"/usr/share/doc/${PF}/html/{*.html,figures} "${D}"/usr/share/doc/${PF}/html/${lang} \
				|| die "mv failed on ${lang}"
			eend $?
		fi
	done

	einfo "Creating symlink to PHP manual at /usr/share/php-docs"
	dosym /usr/share/doc/${PF}/html /usr/share/php-docs
}
