# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Chris Houser <chouser@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-util/arch/arch-1.0_pre5.ebuild,v 1.1 2002/02/07 04:33:06 chouser Exp $

P="${P//_/}"
S="${WORKDIR}/${P}/src/=build"
DESCRIPTION="revision control system ideal for widely distributed development"
SRC_URI="ftp://regexps.com/pub/src/arch/${P}.tar.gz"
HOMEPAGE="http://www.regexps.com/#arch"

DEPEND="sys-apps/diffutils
	sys-apps/fileutils
	sys-apps/findutils
	sys-apps/gawk
	sys-apps/sh-utils
	sys-apps/tar
	sys-apps/textutils
	sys-apps/util-linux
	sys-devel/make
	sys-devel/patch"

src_unpack() {
	unpack "${A}"
	mkdir -p "${P}/src/=build"

	# patch the arch command to put /usr/bin at the front of it's PATH
	# this allows us to survive with the existance of a /bin/arch too
	# could be done by requiring every user to set their .arch-params/path
	t="${P}/src/arch/arch/arch.sh.in"
	cp $t $t.orig
	sed 's-# Set the PATH.*-&\
PATH="/usr/bin:$PATH"-' $t.orig > $t
	assert "Patch failed for $t"
}

src_compile() {
	# configure
	../configure \
		--prefix "/usr" \
		--with-posix-shell "/bin/bash" \
		|| die "configure failed"

	# build
	emake || die "emake failed"
}

src_install () {
	# install
	make install prefix="${D}/usr" \
		|| die "make install failed"

	# make some symlinks relative instead of absolute
	find ${D}/usr/libexec/arch/arch -type l \
		| xargs ls -l \
		| sed "s:^.*-> ${D}/usr/libexec/arch/::" \
		| while read ls; do
			ln -sf "../$ls" "${D}/usr/libexec/arch/arch/${ls#*/}"
			assert "Fixing symlink for $ls failed"
		done

	# make a script so users can type "tlarch" instead of "/usr/bin/arch"
	# note that arch uses it's name, so this can't be a symlink or use exec
	echo -e '#!/bin/bash\n/usr/bin/arch "$@"' > "${D}/usr/bin/tlarch"
	chmod ugo+x "${D}/usr/bin/tlarch" || die "Creating tlarch failed"

	# get some docs
	cd ../..
	dodoc =NEWS =README COPYING
}

pkg_postinst() {
	echo "You may run Tom Lord's 'arch' command as 'tlarch'"
}
