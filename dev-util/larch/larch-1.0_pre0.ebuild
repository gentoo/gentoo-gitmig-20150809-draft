# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/larch/larch-1.0_pre0.ebuild,v 1.6 2004/07/14 23:51:52 agriffis Exp $

MY_P="${P//_/}"
DESCRIPTION="revision control system ideal for widely distributed development (see \"tla\" also)"
SRC_URI="http://regexps.srparish.net/src/larch/${MY_P}.tar.gz"
HOMEPAGE="http://regexps.srparish.net/www/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~alpha ~ppc"
IUSE="doc"

S="${WORKDIR}/${MY_P}/src/=build"

DEPEND="sys-apps/diffutils
	sys-apps/coreutils
	sys-apps/findutils
	sys-apps/gawk
	app-arch/tar
	sys-apps/util-linux
	sys-apps/debianutils
	sys-devel/make
	sys-devel/patch
	app-shells/ash"
## hmm. "larch --help-commands" fails with dash -- so we use "ash"
#	app-shells/dash
## => report bug to dash-people? Posix 1003.1-2001 filename-expansion with
##	wildcards fail: "*/foo"

src_unpack() {
	local t

	unpack "${A}"
	mkdir -p "${MY_P}/src/=build"

	# patch arch to install its scripts in /usr/share/arch
	# instead of /usr/libexec/arch (there is only shareables scripts).
	t="${MY_P}/src/build-tools/Makefiles/rules.mk"

	cp ${t} ${t}.orig
	sed 's:/libexec:/share:g' ${t}.orig > ${t} || die "Patch failed for $t"

	t="${MY_P}/src/build-tools/Makefiles/install-shell-subcommands.mk"
	cp ${t} ${t}.orig
	sed 's:/libexec:/share:g' ${t}.orig > ${t} || die "Patch failed for $t"
}

src_compile() {
	../configure \
		--prefix="/usr" \
		--with-posix-shell="/bin/ash" \
		--with-sendmail="/usr/sbin/sendmail" || die "configure failed"

	# parallel make may cause problems with this package
	make || die "make failed"
	make test || die "tests failed!"
}

src_install () {
	local name

	make install prefix="${D}/usr" \
		|| die "make install failed"

	for name in ${D}/usr/share/arch/arch/*; do
		name="`readlink ${name} | sed 's:^.*/usr/share/arch/::'`"
		if [ "${name}" ]; then
			ln -sf "../${name}" "${D}/usr/share/arch/arch/${name#*/}"
			assert "Fixing symlink for ${name} failed"
		fi
	done

	# get some docs
	cd ${WORKDIR}/${MY_P}/src
	dodoc COPYING
	if use doc; then
		dohtml -r docs-larch
		dodoc docs-larch/ps/arch.ps
	fi
}

pkg_postinst() {
	einfo "also have a look at the C-implementation of larch: \"tla\"."
}
