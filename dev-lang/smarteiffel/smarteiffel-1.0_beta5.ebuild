# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/smarteiffel/smarteiffel-1.0_beta5.ebuild,v 1.5 2004/03/14 02:40:38 mr_bones_ Exp $

IUSE=""

DESCRIPTION="GNU Eiffel compiler"
HOMEPAGE="http://smarteiffel.loria.fr/"

#the source as distributed by authors has no versioning in its name,
#this will break things when new version comes out.
#just point SRC_URI to ibiblio mirror instead (with mangled name of source uploaded)
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="sys-devel/gcc"

S="${WORKDIR}/SmartEiffel"

src_compile() {
	export SmartEiffel="${S}/sys/system.se"
	export PATH="${S}/bin:${PATH}"
	cd ${S}
	make automatic || die

	# Regenerate a proper loadpath.UNIX file.
	cp sys/loadpath.UNIX sys/loadpath.UNIX.orig
	sed -e "s:^${S}:/usr/lib/${PF}:" \
		sys/loadpath.UNIX.orig > sys/loadpath.UNIX || die

	# Setup proper links in the documentation.
	cd man || die
	for file in *.html; do
		cp ${file} ${file}.orig || die
		sed -e "s:../man/::g" < ${file}.orig > ${file} || die
	done
}

src_install () {
	# TODO: The build process of SmartEiffel doesn't include an install part.
	# Basically, wherever you build it is where you install it. :) For now,
	# we'll just do our own adhoc, FHS-compliant install step.
	#
	# Hopefully, SmartEiffel developers will move towards a more GNUlitical
	# program in the future (i.e. Nice trivial configure and make process).
	dodir /usr/lib/${PF}
	cp -a ${S}/lib ${D}/usr/lib/${PF} || die
	cp -a ${S}/tools ${D}/usr/lib/${PF} || die
	cp -a ${S}/sys ${D}/usr/lib/${PF} || die
	cp -a ${S}/bin ${D}/usr/lib/${PF} || die

	# Create symlinks to the appropriate executable binaries.
	dodir /usr/bin
	for NAME in ${S}/bin/*; do
		NAME=`basename ${NAME}`
		# Mangle 'compile' to 'se-compile'
		if [ ${NAME} = "compile" ]; then
			dosym /usr/lib/${PF}/bin/${NAME} /usr/bin/se-compile
		else
			dosym /usr/lib/${PF}/bin/${NAME} /usr/bin/${NAME}
		fi
	done

	# Setup 'SmartEiffel' environment variable.
	dodir /etc/env.d
	echo "SmartEiffel=/usr/lib/${PF}/sys/system.se" > \
		${D}/etc/env.d/20smarteiffel || die

	dodoc READ_ME
	dohtml ${S}/man/*.html
}
