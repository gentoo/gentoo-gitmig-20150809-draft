# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/ccc/ccc-6.5.6.002.ebuild,v 1.1 2003/04/12 03:44:48 agriffis Exp $
#
# Ebuild contributed by Tavis Ormandy <taviso@sdf.lonestar.org>
# and edited by Aron Griffis <agriffis@gentoo.org>

IUSE="doc"

DESCRIPTION="Compaq's enhanced C compiler for the ALPHA platform"
HOMEPAGE="http://www.support.compaq.com/alpha-tools"

# Don't include the SRC_URI because this package is
# license-challenged.  The users need to download this software
# themselves.
#SRC_URI="ftp://ftp.compaq.com/pub/products/C-Cxx/linux/compaq_c_beta/ccc-6.5.6.002-1.alpha.rpm"

S=${WORKDIR}
LICENSE="ccc-beta"
SLOT="0"
# NOTE: ALPHA Only!
KEYWORDS="-* ~alpha"

DEPEND="sys-devel/gcc-config
	app-arch/rpm2targz
	>=sys-apps/sed-4"

RDEPEND="virtual/glibc
	dev-libs/libots
	dev-libs/libcpml"

# This variable is not used by Portage, but is used by the functions
# below.
ccc_release="${PV}-1"

src_unpack() {
	# convert rpm into tar archive
	local ccc_rpm="ccc-${ccc_release}.alpha.rpm"

	if [ ! -f ${DISTDIR}/${ccc_rpm} ]; then
		eerror ""
		eerror "Please download ${ccc_rpm} from" 
		eerror "${HOMEPAGE}, and place it in"
		eerror "${DISTDIR}"
		eerror ""
		eerror "Then restart this emerge."
		eerror ""
		die "ccc distribution (${ccc_rpm}) not found"
	fi

	ebegin "Unpacking ccc distribution..."
	# This is the same as using rpm2targz then extracting 'cept that
	# it's faster, less work, and less hard disk space.  rpmoffset is
	# provided by the rpm2targz package.
	i=${DISTDIR}/${ccc_rpm}
	dd ibs=`rpmoffset < ${i}` skip=1 if=$i 2>/dev/null \
		| gzip -dc | cpio -idmu 2>/dev/null \
		&& find usr -type d -print0 | xargs -0 chmod a+rx
	eend ${?}
	assert "Failed to extract ${ccc_rpm%.rpm}.tar.gz"
}

src_compile() {
	# remove unwanted documentation
	if ! use doc >/dev/null; then
		einfo "Removing unwanted documentation (USE=\"-doc\")..."
		rm -rf usr/doc
	fi

	# fix up lib paths - bug #15719, comment 6
	einfo "Copying crtbegin/crtend from gcc..."
	gcc_libs_path="`gcc-config --get-lib-path`"
	if [ $? != 0 ] || [ ! -d "${gcc_libs_path}" ]; then
		die "gcc-config returned an invalid library path (${gcc_libs_path})"
	else
		cp -f ${gcc_libs_path}/crt{begin,end}.o \
			usr/lib/compaq/ccc-${ccc_release}/alpha-linux/bin
		assert "Failed to copy crtbegin/crtend.o from ${gcc_libs_path}"
	fi

	# add gcc-lib path to ccc's search path
	# check man ccc for file format info.
	einfo "Configuring ccc to observe gcc library path and include paths..."
	printf '%s %s %s\n' \
		"-L${gcc_libs_path}" \
		" -SysIncDir /usr/lib/compaq/ccc-${ccc_release}/alpha-linux/include" \
		" -SysIncDir /usr/include/linux" \
		> usr/lib/compaq/ccc-${ccc_release}/alpha-linux/bin/comp.config
	einfo "Additional paths can be set by users using \$DEC_CC variable."

	# man pages are in the wrong place
	einfo "Reorganising man structure..."
	rm -rf usr/man
	mkdir usr/share
	mv usr/lib/compaq/ccc-${ccc_release}/alpha-linux/man usr/share

	if use doc >/dev/null; then
		einfo "Reorganising documentation..."
		mv usr/doc usr/share
	fi

	# fix the probing script to ignore the version of libcpml.  This
	# is the wrong approach, but it will do for the first pass at this
	# package
	sed -i 's/^  version_high_enough /  true /' \
		usr/lib/compaq/ccc-${ccc_release}/alpha-linux/bin/probe_linux.sh
}

src_install() {
	# move files over
	mv usr ${D} || die "ccc installation failed"

	# prep manpages
	prepman ${D}/usr/share/man/man1/ccc.1
	prepman ${D}/usr/share/man/man8/protect_headers_setup.8
	prepalldocs
}

pkg_config () {
	# some information for users
	einfo
	einfo "Attempting configuration of ccc..."
	einfo
	echo
	echo '<------- Begin ccc configuration output ------->'
	# NOTE: _must_ hide distcc, ccache, etc during this step
	PATH=/bin:/usr/bin:/sbin:/usr/sbin \
	  /usr/lib/compaq/ccc-${ccc_release}/alpha-linux/bin/create-comp-config.sh \
	  ccc-${ccc_release} ${gcc_libs_path}
	echo '<------- End ccc configuration output ------->'
	echo
	einfo
	einfo "ccc has been configured, you can now use it as usual."
	einfo
}

pkg_postinst () {
	einfo
	einfo "ccc has been merged successfully, the EULA"
	einfo "is available in"
	einfo
	einfo "/usr/lib/compaq/ccc-${ccc_release}/alpha-linux/bin/LICENSE.txt"
	einfo
	if use doc >/dev/null; then
		einfo "You can also view the compiler documentation"
		einfo "in /usr/share/doc/ccc-${PV}"
	fi
	ewarn
	ewarn "you _MUST_ now run:"
	ewarn "ebuild /var/db/pkg/dev-lang/${PF}/${PF}.ebuild config"
	ewarn "to complete the installation"
	ewarn
	einfo "Hopefullly soon we will get a ccc USE flag"
	einfo "on packages (or at least individual       "
	einfo "components) that can be successfully built"
	einfo "using this compiler, until then you will  "
	einfo "just have to experiment :)                "
	einfo
	einfo "Please report successes/failures with ccc "
	einfo "to http://bugs.gentoo.org so that the USE "
	einfo "flags can be updated.                     "
	einfo
}
