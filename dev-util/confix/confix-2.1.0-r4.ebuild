# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/confix/confix-2.1.0-r4.ebuild,v 1.2 2010/10/11 12:45:54 haubi Exp $

inherit distutils eutils

DESCRIPTION="Confix: A Build Tool on Top of GNU Automake"
HOMEPAGE="http://confix.sourceforge.net"
SRC_URI="mirror://sourceforge/confix/Confix-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~amd64 ~x86 ~ppc-aix ~hppa-hpux ~ia64-hpux ~x86-interix ~x86-linux ~sparc-solaris ~x86-solaris"
IUSE=""

DEPEND="dev-lang/python"
RDEPEND="${DEPEND}
	sys-devel/automake
	sys-devel/libtool
	sys-devel/autoconf-archive
	dev-util/confix-wrapper
"

S="${WORKDIR}/Confix-${PV}"
PYTHON_MODNAME="libconfix tests"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# find jni-include dirs on hpux.
	epatch "${FILESDIR}"/${PV}/jni-hpux.patch
	# hack to ignore duplicate files in rescan
	epatch "${FILESDIR}"/${PV}/CALL_RESCAN_HACK.patch
	# add .exe extension to TESTS
	epatch "${FILESDIR}"/${PV}/exeext.patch
	# use external autoconf archive
	epatch "${FILESDIR}"/${PV}/ext-ac-archive.patch
	# enable SET_FILE_PROPERTIES(file, { 'PRIVATE_CINCLUDE', 1 })
	epatch "${FILESDIR}"/${PV}/private-headers.patch
	# enable fast installation rules.
	epatch "${FILESDIR}"/${PV}/fast-install.patch
	# link local libraries first.
	epatch "${FILESDIR}"/${PV}/local-libs-first.patch

	# need to store repos in exact versioned share/confix-PV/repo
	sed -i -e "s,'confix2','confix-${PV}'," \
		libconfix/core/automake/repo_automake.py \
	|| die "cannot adjust repo dir"

	# adjust version-printing to have same version as share/confix-PV/repo,
	# to ease revdep-rebuild-alike scripts for rebuilding confix-packages.
	sed -i -e "/^CONFIX_VERSION[ 	]*=/s,.*,CONFIX_VERSION = '${PV}'," \
		libconfix/core/utils/const.py \
	|| die "cannot adjust confix version"
}

pkg_preinst() {
	if has_version '<dev-util/confix-2.1.0-r3'; then
		einfo "After upgrading to ${P} you likely want to remerge all packages built"
		einfo "with <dev-util/confix-2.1.0-r03.1 in your EPREFIX to fix a bug in"
		einfo "libtool's la-files created using the old ${PN}."
		ewarn
		ewarn "Use this command (copy&paste) to identify packages built with <confix-2.1.0-r3"
		ewarn "needing a remerge in your particular instance of Gentoo Prefix:"
		ewarn
		# use 'echo' to get this command from here:
		ewarn "( cd \$(portageq envvar EPREFIX)/var/db/pkg || exit 1;" \
			  "pattern=\$(cd ../../.. && echo \$(grep -l" \
			  "'/portage/[^/]*/[^/]*/work/' usr/lib/lib*.la)" \
			  "| sed -e 's, ,|,g'); if [[ -z \${pattern} ]]; then" \
			  "echo 'No more packages were built with broken Confix.'; exit 0; fi;" \
			  "emerge --ask --oneshot \$(grep -lE \"(\${pattern})\"" \
			  "*/*/CONTENTS | xargs grep -l usr/share/confix-2.1.0/repo" \
			  "| sed -e 's,^,=,;s,/CONTENTS,,')" \
			  ")"
		ewarn
	fi
}
