#!/bin/bash
# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Martin Schlemmer <azarah@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/eclass/libtool.eclass,v 1.13 2002/08/29 23:56:15 azarah Exp $
# This eclass patches ltmain.sh distributed with libtoolized packages with the
# relink and portage patch
ECLASS=libtool
INHERITED="$INHERITED $ECLASS"

newdepend sys-devel/libtool

DESCRIPTION="Based on the ${ECLASS} eclass"

ELIBTOOL_VERSION=1.8.1

elibtoolize() {

	local x=""
	local y=""
	local dopatch="no"
	local dotest="yes"
	local dorelink="yes"
	local dotmp="yes"
	local doportage="yes"
	local portage="no"
	local reversedeps="no"
	local mylist=""

	mylist="$(find_ltmain)"
	for x in ${*}
	do
		# Only apply portage patch, and dont "libtoolize --copy --force"
		# if all patches fail.
		if [ "${x}" = "--portage" ]
		then
			portage="yes"
		fi
		# Apply the reverse-deps patch
		#
		# http://bugzilla.gnome.org/show_bug.cgi?id=75635
		if [ "${x}" = "--reverse-deps" ]
		then
			reversedeps="yes"
		fi
		# Only patch the ltmain.sh in ${S}
		if [ "${x}" = "--shallow" ]
		then
			if [ -f ${S}/ltmain.sh ]
			then
				mylist="${S}"
			else
				mylist=""
			fi
		else
			mylist="$(find_ltmain)"
		fi
	done

	for x in ${mylist}
	do
		cd ${x}
		einfo "Working directory: ${x}..."
		dopatch="yes"
		dotest="yes"
		dorelink="yes"
		dotmp="yes"
		doportage="yes"

		for y in test_patch relink_patch tmp_patch portage_patch
		do
			if ! eval ${y} --test $>${T}/elibtool.log
			then
				case ${y} in
					test_patch)
						# non critical patch
						dotest="no"
						;;
					relink_patch)
						# critical patch, but could be applied
						if [ -z "$(grep -e "inst_prefix_dir" ltmain.sh)" ] && \
						   [ "${portage}" = "no" ]
						then
							dopatch="no"
						fi
						dorelink="no"
						;;
					tmp_patch)
						# non critical patch
						dotmp="no"
						;;
					portage_patch)
						# critical patch
						if [ "${portage}" = "yes" ]
						then
							echo
							eerror "Portage patch requested, but failed to apply!"
							die
						fi
						dopatch="no"
						doportage="no"
						;;
				esac
			fi
		done

# Only apply portage patch ... I think if other can apply, they should.
#		if [ "${portage}" = "yes" ]
#		then
#			dotest="no"
#			dorelink="no"
#			dotmp="no"
#		fi

		for y in test_patch relink_patch tmp_patch portage_patch
		do
			if [ "${dopatch}" = "yes" ]
			then
				case ${y} in
					test_patch)
						if [ "${dotest}" = "no" ]
						then
							continue
						fi
						;;
					relink_patch)
						if [ "${dorelink}" = "no" ]
						then
							continue
						fi
						;;
					tmp_patch)
						if [ "${dotmp}" = "no" ]
						then
							continue
						fi
						;;
					portage_patch)
						if [ "${doportage}" = "no" ]
						then
							continue
						fi
						;;
				esac
				
				einfo "Applying libtool-${y/_patch/}.patch..."
				eval ${y} $>${T}/elibtool.log
			elif [ "${portage}" = "no" ] && [ "${reversedeps}" = "no" ]
			then
				ewarn "Cannot apply any patch, running libtoolize..."
				libtoolize --copy --force
				break
			fi
		done

		if [ "${reversedeps}" = "yes" ]
		then
			if eval reversedeps_patch --test $>${T}/libtool.foo
			then
				einfo "Applying libtool-reverse-deps.patch..."
				eval reversedeps_patch $>${T}/libtool.foo
			fi
		fi
	done

	if [ -f libtool ]
	then
		rm -f libtool
	fi

	# We need to change the pwd back to $S, as we may be called in
	# src_compile()
	cd ${S}
}

#
# Returns all the directories containing ltmain.sh
#
find_ltmain() {
	
	local x=""
	local dirlist=""

	for x in $(find ${S} -name 'ltmain.sh')
	do
		dirlist="${dirlist} ${x%/*}"
	done

	echo "${dirlist}"
}

#
# Various patches we want to apply.
#
# Contains:  portage_patch
#            relink_patch
#            test_patch
#
portage_patch() {

	local opts=""

	if [ "${1}" = "--test" ]
	then
		opts="--force --dry-run"
	fi

	patch ${opts} -p0 <<-"ENDPATCH"
		--- ltmain.sh.orig	Wed Apr  3 01:19:37 2002
		+++ ltmain.sh	Sun May 26 19:50:52 2002
		@@ -3940,9 +3940,46 @@
		 		  $echo "$modename: \`$deplib' is not a valid libtool archive" 1>&2
		 		  exit 1
		 		fi
		-		newdependency_libs="$newdependency_libs $libdir/$name"
		+		# We do not want portage's install root ($D) present.  Check only for
		+		# this if the .la is being installed.
		+		if test "$installed" = yes && test "$D"; then
		+		  eval mynewdependency_lib="`echo "$libdir/$name" |sed -e "s:$D::g" -e 's://:/:g'`"
		+		else
		+		  mynewdependency_lib="$libdir/$name"
		+		fi
		+		# Do not add duplicates
		+		if test "$mynewdependency_lib"; then
		+		  if test -z "`echo $newdependency_libs |grep -e "$mynewdependency_lib"`"; then
		+		    newdependency_libs="$newdependency_libs $mynewdependency_lib"
		+		  fi
		+		fi
		+		;;
		+		  *)
		+		if test "$installed" = yes; then
		+		  # Rather use S=WORKDIR if our version of portage supports it.
		+		  # This is because some ebuild (gcc) do not use $S as buildroot.
		+		  if test "$PWORKDIR"; then
		+		    S="$PWORKDIR"
		+		  fi
		+		  # We do not want portage's build root ($S) present.
		+		  if test -n "`echo $deplib |grep -e "$S"`" && test "$S"; then
		+		    mynewdependency_lib=""
		+		  # We do not want portage's install root ($D) present.
		+		  elif test -n "`echo $deplib |grep -e "$D"`" && test "$D"; then
		+		    eval mynewdependency_lib="`echo "$deplib" |sed -e "s:$D::g" -e 's://:/:g'`"
		+		  else
		+		    mynewdependency_lib="$deplib"
		+		  fi
		+		else
		+		  mynewdependency_lib="$deplib"
		+		fi
		+		# Do not add duplicates
		+		if test "$mynewdependency_lib"; then
		+		  if test -z "`echo $newdependency_libs |grep -e "$mynewdependency_lib"`"; then
		+		    newdependency_libs="$newdependency_libs $mynewdependency_lib"
		+		  fi
		+		fi
		 		;;
		-	      *) newdependency_libs="$newdependency_libs $deplib" ;;
		 	      esac
		 	    done
		 	    dependency_libs="$newdependency_libs"
		@@ -3975,6 +4005,10 @@
		 	  case $host,$output,$installed,$module,$dlname in
		 	    *cygwin*,*lai,yes,no,*.dll) tdlname=../bin/$dlname ;;
		 	  esac
		+	  # Do not add duplicates
		+	  if test "$installed" = yes && test "$D"; then
		+	    install_libdir="`echo "$install_libdir" |sed -e "s:$D::g" -e 's://:/:g'`"
		+	  fi
		 	  $echo > $output "\
		 # $outputname - a libtool library file
		 # Generated by $PROGRAM - GNU $PACKAGE $VERSION$TIMESTAMP
	ENDPATCH
}

relink_patch() {

	local opts=""
	local retval=0

	if [ "${1}" = "--test" ]
	then
		opts="--force --dry-run"
	fi

	patch ${opts} -p0 <<-"ENDPATCH"
		--- ltmain.sh	Sun Aug 12 18:08:05 2001
		+++ ltmain-relinkable.sh	Tue Aug 28 18:55:13 2001
		@@ -827,6 +827,7 @@
		     linker_flags=
		     dllsearchpath=
		     lib_search_path=`pwd`
		+    inst_prefix_dir=
		 
		     avoid_version=no
		     dlfiles=
		@@ -959,6 +960,11 @@
		 	  prev=
		 	  continue
		 	  ;;
		+        inst_prefix)
		+	  inst_prefix_dir="$arg"
		+	  prev=
		+	  continue
		+	  ;;
		 	release)
		 	  release="-$arg"
		 	  prev=
		@@ -1167,6 +1173,11 @@
		 	continue
		 	;;
		 
		+      -inst-prefix-dir)
		+	prev=inst_prefix
		+	continue
		+	;;
		+
		       # The native IRIX linker understands -LANG:*, -LIST:* and -LNO:*
		       # so, if we see these flags be careful not to treat them like -L
		       -L[A-Z][A-Z]*:*)
		@@ -2231,7 +2242,16 @@
		 	    if test "$hardcode_direct" = yes; then
		 	      add="$libdir/$linklib"
		 	    elif test "$hardcode_minus_L" = yes; then
		-	      add_dir="-L$libdir"
		+	      # Try looking first in the location we're being installed to.
		+	      add_dir=
		+	      if test -n "$inst_prefix_dir"; then
		+		case "$libdir" in
		+		[\\/]*)
		+		  add_dir="-L$inst_prefix_dir$libdir"
		+		  ;;
		+		esac
		+	      fi
		+	      add_dir="$add_dir -L$libdir"
		 	      add="-l$name"
		 	    elif test "$hardcode_shlibpath_var" = yes; then
		 	      case :$finalize_shlibpath: in
		@@ -2241,7 +2261,16 @@
		 	      add="-l$name"
		 	    else
		 	      # We cannot seem to hardcode it, guess we'll fake it.
		-	      add_dir="-L$libdir"
		+	      # Try looking first in the location we're being installed to.
		+	      add_dir=
		+	      if test -n "$inst_prefix_dir"; then
		+		case "$libdir" in
		+		[\\/]*)
		+		  add_dir="-L$inst_prefix_dir$libdir"
		+		  ;;
		+		esac
		+	      fi
		+	      add_dir="$add_dir -L$libdir"
		 	      add="-l$name"
		 	    fi
		 
		@@ -4622,12 +4651,30 @@
		 	dir="$dir$objdir"
		 
		 	if test -n "$relink_command"; then
		+	  # Determine the prefix the user has applied to our future dir.
		+	  inst_prefix_dir=`$echo "$destdir" | sed "s%$libdir\$%%"`
		+
		+	  # Don't allow the user to place us outside of our expected
		+	  # location b/c this prevents finding dependent libraries that
		+	  # are installed to the same prefix.
		+	  if test "$inst_prefix_dir" = "$destdir"; then
		+	    $echo "$modename: error: cannot install \`$file' to a directory not ending in $libdir" 1>&2
		+	    exit 1
		+	  fi
		+
		+	  if test -n "$inst_prefix_dir"; then
		+	    # Stick the inst_prefix_dir data into the link command.
		+	    relink_command=`$echo "$relink_command" | sed "s%@inst_prefix_dir@%-inst-prefix-dir $inst_prefix_dir%"`
		+	  else
		+	    relink_command=`$echo "$relink_command" | sed "s%@inst_prefix_dir@%%"`
		+	  fi
		+
		 	  $echo "$modename: warning: relinking \`$file'" 1>&2
		 	  $show "$relink_command"
		 	  if $run eval "$relink_command"; then :
		 	  else
		 	    $echo "$modename: error: relink \`$file' with the above command before installing it" 1>&2
		-	    continue
		+	    exit 1
		 	  fi
		 	fi
		 
	ENDPATCH

    retval=$?

    # This one dont apply clean to libtool-1.4.2a, so do it manually.
    if [ "${1}" != "--test" ] && [ "${retval}" -eq 0 ]
    then
        cp ltmain.sh ltmain.sh.orig
        sed -e 's:cd `pwd`; $SHELL $0 --mode=relink $libtool_args:cd `pwd`; $SHELL $0 --mode=relink $libtool_args @inst_prefix_dir@:' \
            ltmain.sh.orig > ltmain.sh
        rm -f ltmain.sh.orig
    fi

    return ${retval}
}

tmp_patch() {

	local opts=""

	if [ "${1}" = "--test" ]
	then
		opts="--force --dry-run"
	fi
	
	patch ${opts} -p0 <<-"ENDPATCH"
		--- ltmain.sh   Sun Aug 12 18:08:05 2001
		+++ ltmain-relinkable.sh    Tue Aug 28 18:55:13 2001
		@@ -4782,7 +4829,11 @@
		 	    if test "$finalize" = yes && test -z "$run"; then
		 	      tmpdir="/tmp"
		 	      test -n "$TMPDIR" && tmpdir="$TMPDIR"
		-	      tmpdir="$tmpdir/libtool-$$"
		+              tmpdir=`mktemp -d $tmpdir/libtool-XXXXXX 2> /dev/null`
		+              if test $? = 0 ; then :
		+              else
		+                tmpdir="$tmpdir/libtool-$$"
		+              fi
		 	      if $mkdir -p "$tmpdir" && chmod 700 "$tmpdir"; then :
		 	      else
		 		$echo "$modename: error: cannot create temporary directory \`$tmpdir'" 1>&2
	ENDPATCH
}

test_patch() {

	local opts=""

	if [ "${1}" = "--test" ]
	then
		opts="--force --dry-run"
	fi

	patch ${opts} -p0 <<-"ENDPATCH"
		--- ./ltmain.sh	Tue May 29 19:16:03 2001
		+++ ./ltmain.sh	Tue May 29 21:26:50 2001
		@@ -459,7 +459,7 @@
		       pic_mode=default
		       ;;
		     esac
		-    if test $pic_mode = no && test "$deplibs_check_method" != pass_all; then
		+    if test "$pic_mode" = no && test "$deplibs_check_method" != pass_all; then
		       # non-PIC code in shared libraries is not supported
		       pic_mode=default
		     fi
		@@ -1343,7 +1343,7 @@
		 	;;
		     esac
		     for pass in $passes; do
		-      if test $linkmode = prog; then
		+      if test "$linkmode" = prog; then
		 	# Determine which files to process
		 	case $pass in
		 	dlopen)
		@@ -1360,11 +1360,11 @@
		 	found=no
		 	case $deplib in
		 	-l*)
		-	  if test $linkmode = oldlib && test $linkmode = obj; then
		+	  if test "$linkmode" = oldlib && test "$linkmode" = obj; then
		 	    $echo "$modename: warning: \`-l' is ignored for archives/objects: $deplib" 1>&2
		 	    continue
		 	  fi
		-	  if test $pass = conv; then
		+	  if test "$pass" = conv; then
		 	    deplibs="$deplib $deplibs"
		 	    continue
		 	  fi
		@@ -1384,7 +1384,7 @@
		 	      finalize_deplibs="$deplib $finalize_deplibs"
		 	    else
		 	      deplibs="$deplib $deplibs"
		-	      test $linkmode = lib && newdependency_libs="$deplib $newdependency_libs"
		+	      test "$linkmode" = lib && newdependency_libs="$deplib $newdependency_libs"
		 	    fi
		 	    continue
		 	  fi
		@@ -1393,16 +1393,16 @@
		 	  case $linkmode in
		 	  lib)
		 	    deplibs="$deplib $deplibs"
		-	    test $pass = conv && continue
		+	    test "$pass" = conv && continue
		 	    newdependency_libs="$deplib $newdependency_libs"
		 	    newlib_search_path="$newlib_search_path "`$echo "X$deplib" | $Xsed -e 's/^-L//'`
		 	    ;;
		 	  prog)
		-	    if test $pass = conv; then
		+	    if test "$pass" = conv; then
		 	      deplibs="$deplib $deplibs"
		 	      continue
		 	    fi
		-	    if test $pass = scan; then
		+	    if test "$pass" = scan; then
		 	      deplibs="$deplib $deplibs"
		 	      newlib_search_path="$newlib_search_path "`$echo "X$deplib" | $Xsed -e 's/^-L//'`
		 	    else
		@@ -1417,7 +1417,7 @@
		 	  continue
		 	  ;; # -L
		 	-R*)
		-	  if test $pass = link; then
		+	  if test "$pass" = link; then
		 	    dir=`$echo "X$deplib" | $Xsed -e 's/^-R//'`
		 	    # Make sure the xrpath contains only unique directories.
		 	    case "$xrpath " in
		@@ -1430,7 +1430,7 @@
		 	  ;;
		 	*.la) lib="$deplib" ;;
		 	*.$libext)
		-	  if test $pass = conv; then
		+	  if test "$pass" = conv; then
		 	    deplibs="$deplib $deplibs"
		 	    continue
		 	  fi
		@@ -1451,7 +1451,7 @@
		 	    continue
		 	    ;;
		 	  prog)
		-	    if test $pass != link; then
		+	    if test "$pass" != link; then
		 	      deplibs="$deplib $deplibs"
		 	    else
		 	      compile_deplibs="$deplib $compile_deplibs"
		@@ -1462,7 +1462,7 @@
		 	  esac # linkmode
		 	  ;; # *.$libext
		 	*.lo | *.$objext)
		-	  if test $pass = dlpreopen || test "$dlopen_support" != yes || test "$build_libtool_libs" = no; then
		+	  if test "$pass" = dlpreopen || test "$dlopen_support" != yes || test "$build_libtool_libs" = no; then
		 	    # If there is no dlopen support or we're linking statically,
		 	    # we need to preload.
		 	    newdlprefiles="$newdlprefiles $deplib"
		@@ -1512,13 +1512,13 @@
		 
		 	if test "$linkmode,$pass" = "lib,link" ||
		 	   test "$linkmode,$pass" = "prog,scan" ||
		-	   { test $linkmode = oldlib && test $linkmode = obj; }; then
		+	   { test "$linkmode" = oldlib && test "$linkmode" = obj; }; then
		 	   # Add dl[pre]opened files of deplib
		 	  test -n "$dlopen" && dlfiles="$dlfiles $dlopen"
		 	  test -n "$dlpreopen" && dlprefiles="$dlprefiles $dlpreopen"
		 	fi
		 
		-	if test $pass = conv; then
		+	if test "$pass" = conv; then
		 	  # Only check for convenience libraries
		 	  deplibs="$lib $deplibs"
		 	  if test -z "$libdir"; then
		@@ -1537,7 +1537,7 @@
		 	      esac
		 	      tmp_libs="$tmp_libs $deplib"
		 	    done
		-	  elif test $linkmode != prog && test $linkmode != lib; then
		+	  elif test "$linkmode" != prog && test "$linkmode" != lib; then
		 	    $echo "$modename: \`$lib' is not a convenience library" 1>&2
		 	    exit 1
		 	  fi
		@@ -1555,7 +1555,7 @@
		 	fi
		 
		 	# This library was specified with -dlopen.
		-	if test $pass = dlopen; then
		+	if test "$pass" = dlopen; then
		 	  if test -z "$libdir"; then
		 	    $echo "$modename: cannot -dlopen a convenience library: \`$lib'" 1>&2
		 	    exit 1
		@@ -1604,7 +1604,7 @@
		 	name=`$echo "X$laname" | $Xsed -e 's/\.la$//' -e 's/^lib//'`
		 
		 	# This library was specified with -dlpreopen.
		-	if test $pass = dlpreopen; then
		+	if test "$pass" = dlpreopen; then
		 	  if test -z "$libdir"; then
		 	    $echo "$modename: cannot -dlpreopen a convenience library: \`$lib'" 1>&2
		 	    exit 1
		@@ -1623,7 +1623,7 @@
		 
		 	if test -z "$libdir"; then
		 	  # Link the convenience library
		-	  if test $linkmode = lib; then
		+	  if test "$linkmode" = lib; then
		 	    deplibs="$dir/$old_library $deplibs"
		 	  elif test "$linkmode,$pass" = "prog,link"; then
		 	    compile_deplibs="$dir/$old_library $compile_deplibs"
		@@ -1634,7 +1634,7 @@
		 	  continue
		 	fi
		 
		-	if test $linkmode = prog && test $pass != link; then
		+	if test "$linkmode" = prog && test "$pass" != link; then
		 	  newlib_search_path="$newlib_search_path $ladir"
		 	  deplibs="$lib $deplibs"
		 
		@@ -1671,7 +1671,7 @@
		 	  # Link against this shared library
		 
		 	  if test "$linkmode,$pass" = "prog,link" ||
		-	   { test $linkmode = lib && test $hardcode_into_libs = yes; }; then
		+	   { test "$linkmode" = lib && test "$hardcode_into_libs" = yes; }; then
		 	    # Hardcode the library path.
		 	    # Skip directories that are in the system default run-time
		 	    # search path.
		@@ -1693,7 +1693,7 @@
		 	      esac
		 	      ;;
		 	    esac
		-	    if test $linkmode = prog; then
		+	    if test "$linkmode" = prog; then
		 	      # We need to hardcode the library path
		 	      if test -n "$shlibpath_var"; then
		 		# Make sure the rpath contains only unique directories.
		@@ -1777,7 +1777,7 @@
		 	    linklib=$newlib
		 	  fi # test -n $old_archive_from_expsyms_cmds
		 
		-	  if test $linkmode = prog || test "$mode" != relink; then
		+	  if test "$linkmode" = prog || test "$mode" != relink; then
		 	    add_shlibpath=
		 	    add_dir=
		 	    add=
		@@ -1826,7 +1826,7 @@
		 	      *) compile_shlibpath="$compile_shlibpath$add_shlibpath:" ;;
		 	      esac
		 	    fi
		-	    if test $linkmode = prog; then
		+	    if test "$linkmode" = prog; then
		 	      test -n "$add_dir" && compile_deplibs="$add_dir $compile_deplibs"
		 	      test -n "$add" && compile_deplibs="$add $compile_deplibs"
		 	    else
		@@ -1843,7 +1843,7 @@
		 	    fi
		 	  fi
		 
		-	  if test $linkmode = prog || test "$mode" = relink; then
		+	  if test "$linkmode" = prog || test "$mode" = relink; then
		 	    add_shlibpath=
		 	    add_dir=
		 	    add=
		@@ -1865,7 +1865,7 @@
		 	      add="-l$name"
		 	    fi
		 
		-	    if test $linkmode = prog; then
		+	    if test "$linkmode" = prog; then
		 	      test -n "$add_dir" && finalize_deplibs="$add_dir $finalize_deplibs"
		 	      test -n "$add" && finalize_deplibs="$add $finalize_deplibs"
		 	    else
		@@ -1873,7 +1873,7 @@
		 	      test -n "$add" && deplibs="$add $deplibs"
		 	    fi
		 	  fi
		-	elif test $linkmode = prog; then
		+	elif test "$linkmode" = prog; then
		 	  if test "$alldeplibs" = yes &&
		 	     { test "$deplibs_check_method" = pass_all ||
		 	       { test "$build_libtool_libs" = yes &&
		@@ -1932,9 +1932,9 @@
		 	  fi
		 	fi # link shared/static library?
		 
		-	if test $linkmode = lib; then
		+	if test "$linkmode" = lib; then
		 	  if test -n "$dependency_libs" &&
		-	     { test $hardcode_into_libs != yes || test $build_old_libs = yes ||
		+	     { test "$hardcode_into_libs" != yes || test $build_old_libs = yes ||
		 	       test $link_static = yes; }; then
		 	    # Extract -R from dependency_libs
		 	    temp_deplibs=
		@@ -1964,7 +1964,7 @@
		 	    tmp_libs="$tmp_libs $deplib"
		 	  done
		 
		-	  if test $link_all_deplibs != no; then
		+	  if test "$link_all_deplibs" != no; then
		 	    # Add the search paths of all dependency libraries
		 	    for deplib in $dependency_libs; do
		 	      case $deplib in
		@@ -2007,15 +2007,15 @@
		 	  fi # link_all_deplibs != no
		 	fi # linkmode = lib
		       done # for deplib in $libs
		-      if test $pass = dlpreopen; then
		+      if test "$pass" = dlpreopen; then
		 	# Link the dlpreopened libraries before other libraries
		 	for deplib in $save_deplibs; do
		 	  deplibs="$deplib $deplibs"
		 	done
		       fi
		-      if test $pass != dlopen; then
		-	test $pass != scan && dependency_libs="$newdependency_libs"
		-	if test $pass != conv; then
		+      if test "$pass" != dlopen; then
		+	test "$pass" != scan && dependency_libs="$newdependency_libs"
		+	if test "$pass" != conv; then
		 	  # Make sure lib_search_path contains only unique directories.
		 	  lib_search_path=
		 	  for dir in $newlib_search_path; do
		@@ -2073,7 +2073,7 @@
		 	deplibs=
		       fi
		     done # for pass
		-    if test $linkmode = prog; then
		+    if test "$linkmode" = prog; then
		       dlfiles="$newdlfiles"
		       dlprefiles="$newdlprefiles"
		     fi
		@@ -2410,7 +2410,7 @@
		 	    ;;
		 	  *)
		 	    # Add libc to deplibs on all other systems if necessary.
		-	    if test $build_libtool_need_lc = "yes"; then
		+	    if test "$build_libtool_need_lc" = "yes"; then
		 	      deplibs="$deplibs -lc"
		 	    fi
		 	    ;;
		@@ -2683,7 +2683,7 @@
		 
		       # Test again, we may have decided not to build it any more
		       if test "$build_libtool_libs" = yes; then
		-	if test $hardcode_into_libs = yes; then
		+	if test "$hardcode_into_libs" = yes; then
		 	  # Hardcode the library paths
		 	  hardcode_libdirs=
		 	  dep_rpath=
	ENDPATCH
}

reversedeps_patch() {

	local opts=""

	if [ "${1}" = "--test" ]
	then
		opts="--force --dry-run"
	fi
    
	patch ${opts} -p0 <<-"ENDPATCH"
		--- ltmain.sh.orig	Sat Mar 23 22:48:45 2002
		+++ ltmain.sh	Sat Mar 23 22:45:38 2002
		@@ -1553,6 +1553,8 @@
		 	    convenience="$convenience $ladir/$objdir/$old_library"
		 	    old_convenience="$old_convenience $ladir/$objdir/$old_library"
		 	    tmp_libs=
		+	    # PKGW 
		+	    dependency_libs=
		 	    for deplib in $dependency_libs; do
		 	      deplibs="$deplib $deplibs"
		 	      case "$tmp_libs " in
		@@ -1668,6 +1670,8 @@
		 	  fi
		 
		 	  tmp_libs=
		+	  #PKGW
		+	  dependency_libs=
		 	  for deplib in $dependency_libs; do
		 	    case $deplib in
		 	    -L*) newlib_search_path="$newlib_search_path "`$echo "X$deplib" | $Xsed -e 's/^-L//'`;; ### testsuite: skip nested quoting test
		@@ -2081,7 +2085,7 @@
		 	    -L*)
		 	      case " $tmp_libs " in
		 	      *" $deplib "*) ;;
		-	      *) tmp_libs="$tmp_libs $deplib" ;;
		+	      *) tmp_libs="$deplib $tmp_libs" ;;
		 	      esac
		 	      ;;
		 	    *) tmp_libs="$tmp_libs $deplib" ;;
	ENDPATCH
}

