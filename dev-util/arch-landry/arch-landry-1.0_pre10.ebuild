# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/arch-landry/arch-landry-1.0_pre10.ebuild,v 1.3 2003/11/14 11:43:40 seemant Exp $

MY_P="${P//_/}"
S="${WORKDIR}/${MY_P}/src/=build"
DESCRIPTION="RCS with advanced features, including Walter Landry's patches, based on based on arch-1.0pre16"
SRC_URI="http://superbeast.ucsd.edu/~landry/larch/arch-landry-1.0pre10.tar.gz"
HOMEPAGE="http://www.fifthvision.net/open/bin/view/Arch/WebHome"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=sys-apps/diffutils-2.0
	>=sys-apps/fileutils-4.0
	>=sys-apps/findutils-4.0
	>=sys-apps/gawk-3.0
	>=sys-apps/sh-utils-2.0
	>=app-arch/tar-1.0
	>=sys-apps/textutils-2.0
	>=sys-apps/util-linux-2.0
	>=sys-apps/debianutils-1.10
	>=sys-devel/patch-2.5"
DEPEND="$RDEPEND
	>=sys-devel/make-3.0"

src_unpack() {
	local t

	unpack "${A}"
	mkdir -p "${MY_P}/src/=build"

	# patch arch to install its scripts in /usr/share/arch
	# instead of /usr/libexec/arch (there is only shareables scripts).
	t="${MY_P}/src/build-tools/Makefiles/rules.mk"

	cp ${t} ${t}.orig
	sed 's:/libexec:/share:g' ${t}.orig > ${t} || die "Patch failed for $t"
}

src_compile() {
	../configure \
		--prefix="/usr" \
		--with-posix-shell="/bin/bash" \
		--with-sendmail="/usr/sbin/sendmail" || die "configure failed"

	# parallel make may cause problems with this package
	make || die "make failed"
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
	cd ${WORKDIR}/${MY_P}
	dodoc =NEWS =README COPYING
	dodoc docs/arch.pdf
	dodoc -r docs/examples
	dohtml -r docs/html
}

pkg_postinst() {
	einfo "Tom Lord's/Walter Landry's 'arch' command has been renamed"
	einfo " upstream to 'larch' to stop collision with 'arch' command."
}
