# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2.
# $Header: /var/cvsroot/gentoo-x86/dev-util/arch/arch-1.0_pre15.ebuild,v 1.3 2002/07/23 10:38:06 seemant Exp $

MY_P="${P//_/}"
S="${WORKDIR}/${MY_P}/src/=build"
DESCRIPTION="revision control system ideal for widely distributed development"
SRC_URI="ftp://regexps.com/pub/src/arch/${MY_P}.tar.gz"
HOMEPAGE="http://www.regexps.com/arch.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="sys-apps/diffutils
	sys-apps/fileutils
	sys-apps/findutils
	sys-apps/gawk
	sys-apps/sh-utils
	sys-apps/tar
	sys-apps/textutils
	sys-apps/util-linux
	sys-apps/debianutils
	sys-devel/make
	sys-devel/patch"

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
	dohtml -r docs
}

pkg_postinst() {
	echo "Tom Lord's 'arch' command has been renamed upstream to 'larch'"
	echo "to stop collision with 'arch' command."
}
