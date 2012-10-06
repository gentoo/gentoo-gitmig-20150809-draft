# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/gawk/gawk-4.0.1-r1.ebuild,v 1.1 2012/10/06 12:26:54 ottxor Exp $

EAPI="4"

inherit eutils toolchain-funcs multilib

DESCRIPTION="GNU awk pattern-matching language"
HOMEPAGE="http://www.gnu.org/software/gawk/gawk.html"
SRC_URI="mirror://gnu/gawk/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="nls readline"

# older gawk's provided shared lib for baselayout-1
RDEPEND="!<sys-apps/baselayout-2.0.1
	readline? ( sys-libs/readline )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_prepare() {
	# use symlinks rather than hardlinks, and disable version links
	sed -i \
		-e '/^LN =/s:=.*:= $(LN_S):' \
		-e '/install-exec-hook:/s|$|\nfoo:|' \
		Makefile.in doc/Makefile.in
	sed -i '/^pty1:$/s|$|\n_pty1:|' test/Makefile.in #413327
}

src_configure() {
	export ac_cv_libsigsegv=no
	econf \
		--libexec='$(libdir)/misc' \
		$(use_enable nls) \
		$(use_with readline)
}

src_install() {
	emake install DESTDIR="${D}" || die

	# Install headers
	insinto /usr/include/awk
	doins *.h || die
	rm "${ED}"/usr/include/awk/config.h || die

	dodoc AUTHORS ChangeLog FUTURES LIMITATIONS NEWS PROBLEMS POSIX.STD README README_d/*.*
	for x in */ChangeLog ; do
		newdoc ${x} ${x##*/}.${x%%/*}
	done
}

pkg_postinst() {
	# symlink creation here as the links do not belong to gawk, but to any awk
	if has_version app-admin/eselect && has_version app-admin/eselect-awk ; then
		eselect awk update ifunset
	else
		local l
		for l in "${EROOT}"usr/share/man/man1/gawk.1* "${EROOT}"usr/bin/gawk; do
			[[ -e ${l} && ! -e ${l/gawk/awk} ]] && ln -s "${l##*/}" "${l/gawk/awk}"
		done
		[[ ! -e ${EROOT}bin/awk ]] && ln -s "../usr/bin/gawk" "${EROOT}bin/awk"
	fi
}

pkg_postrm() {
	if has_version app-admin/eselect && has_version app-admin/eselect-awk ; then
		eselect awk update ifunset
	fi
}
