@test "scikit-learn is the correct version" {
  run docker run smizy/scikit-learn:${TAG} pip3 show scikit-learn
  echo "${output}" 

  [ $status -eq 0 ]
  [ "${lines[1]}" = "Version: 1.1.0" ]
}