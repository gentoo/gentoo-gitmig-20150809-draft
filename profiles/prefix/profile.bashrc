# Copyright 1999-2011 Gentoo Foundation; Distributed under the GPL v2
# $Id: profile.bashrc,v 1.3 2011/12/15 20:50:52 grobian Exp $

# Hack to avoid every package that uses libiconv/gettext
# install a charset.alias that will collide with libiconv's one
# See bugs 169678, 195148 and 256129.
# Also the discussion on
# http://archives.gentoo.org/gentoo-dev/msg_8cb1805411f37b4eb168a3e680e531f3.xml
prefix-post_src_install() {
	local f
	if [[ ${PN} != "libiconv" && -n $(ls "${ED}"/usr/lib*/charset.alias 2>/dev/null) ]]; then
		einfo "automatically removing charset.alias"
		rm -f "${ED}"/usr/lib*/charset.alias
	fi
}

# These are because of
# http://archives.gentoo.org/gentoo-dev/msg_529a0806ed2cf841a467940a57e2d588.xml
# The profile-* ones are meant to be used in etc/portage/profile.bashrc by user
# until there is the registration mechanism.
profile-post_src_install() { prefix-post_src_install ; }
        post_src_install() { prefix-post_src_install ; }

# Always add ${EPREFIX}/usr/share/aclocal to accommodate situations where
# aclocal comes from another EPREFIX (for example cross-EPREFIX builds).
# Note: AT_SYS_M4DIR gets eval-ed
[[ -d ${EPREFIX}/usr/share/aclocal ]] && \
	AT_SYS_M4DIR+=' -I ${EPREFIX}/usr/share/aclocal'

