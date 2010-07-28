# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/confix/confix-2.3.0-r3.ebuild,v 1.2 2010/07/28 12:56:32 flameeyes Exp $

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
	epatch "${FILESDIR}"/2.1.0/jni-hpux.patch
	# add .exe extension to TESTS
	epatch "${FILESDIR}"/${PV}/exeext.patch
	# use external autoconf archive
	epatch "${FILESDIR}"/${PV}/ext-ac-archive.patch
	# link local libraries first.
	epatch "${FILESDIR}"/${PV}/local-libs-first.patch
	# don't use automake 1.9, but any newer too...
	epatch "${FILESDIR}"/${PV}/new-automake.patch

	# need to store repos in exact versioned share/confix-PV/repo
	sed -i -e "s,\<confix2\>,confix-${PV}," \
		libconfix/plugins/automake/repo_automake.py \
		libconfix/core/machinery/repo.py \
	|| die "cannot adjust repo dir"
	#	libconfix/plugins/cmake/consts.py \

	# adjust version-printing to have same version as share/confix-PV/repo,
	# to ease revdep-rebuild-alike scripts for rebuilding confix-packages.
	sed -i -e "/^CONFIX_VERSION[ 	]*=/s,.*,CONFIX_VERSION = '${PV}'," \
		libconfix/core/utils/const.py \
	|| die "cannot adjust confix version"
}

pkg_preinst() {
	if has_version "<dev-util/confix-${PV}"; then
		einfo "After merging ${P} you might have to remerge all packages built"
		einfo "with !=dev-util/confix-${PV}* in your EPREFIX to get all the"
		einfo "repo files useable with current ${PN}".
		ewarn
		ewarn "Use this command (copy&paste) to identify packages built with confix"
		ewarn "needing a remerge in your particular instance of Gentoo Prefix:"
		ewarn
		# use 'echo' to get this command from here:
		ewarn "( cd \$(portageq envvar EPREFIX)/var/db/pkg || exit 1;" \
			  "pattern=\$(cd ../../.. && echo \$(ls -d" \
			  "usr/share/confix*/repo | grep -v confix-${PV}) |" \
			  "sed -e 's, ,|,g'); if [[ -z \${pattern} ]]; then echo" \
			  "'No more packages were built with broken Confix.'; exit 0;" \
			  "fi; emerge --ask --oneshot \$(grep -lE \"(\${pattern})\"" \
			  "*/*/CONTENTS | sed -e 's,^,=,;s,/CONTENTS,,')" \
			  ")"
		ewarn
	fi
}
